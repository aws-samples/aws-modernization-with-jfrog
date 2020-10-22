#!/bin/bash 
export LC_ALL=C

#########################################
# This script creates local repositories and virtual repository that include all.
# It also creates groups and permission targets for the repositories.
# Also updates Xray indexes (for the generated repositories), creates policies and watches.
#
# Pre-reqs: 
#  * need to have available:
#      curl  -- for direct REST invocations
#      jfrog -- the jfrog cli tool
#      jq    -- json handling 
#  * artifactory needs to be available and the cli pre-configured with the credentials 


check_for_cli() {
        if ! [ -x "$(command -v jfrog)" ]; then
           echo 'Error: jfrog cli is not installed.' >&2
           exit 1
        fi
}
check_for_curl() {
        if ! [ -x "$(command -v curl)" ]; then
           echo 'Error: curl is not installed.' >&2
           exit 1
        fi
}
check_for_jq() {
        if ! [ -x "$(command -v jq)" ]; then
           echo 'Error: jq is not installed.' >&2
           exit 1
        fi
}
check_rt_status() {
        if ! [ `jfrog rt ping` = "OK" ]; then
           echo "Artifactory ping failed!"
           exit 1
        fi 
}
###### verify jq, curl and cli are installed
check_for_cli
check_for_curl
check_for_jq
######

dirName="config"
BASEURL=`jfrog rt curl --silent --url /api/system/configuration | grep urlBase | sed -E 's/.*>(.*)<.*$/\1/'`

IS_EPLUS=`curl -s -w "%{http_code}" -o /dev/null -u ${int_Artifactory_user}:${int_Artifactory_apikey} ${BASEURL}/distribution/api/v1/system/ping`
        
##################
# If in E+, create access federation
### ASSUMPTION: main JPD has the id of JPD-1, if this is not the case, we'll need to validate what JPD id we are connected to through jfrog CLI.
#
# This will set star access federation from JPD-1 to all other JPDs for ALL security entities.
#
######
if [[ "$IS_EPLUS" = "200" ]]
then
 BASEURL=`jfrog rt curl --silent --url /api/system/configuration | grep urlBase | sed -E 's/.*>(.*)<.*$/\1/'`
 MAIN_SRV_ID=`jfrog rt curl --silent --url /api/system/service_id`
 MAIN_ACC_TOKEN=`jfrog rt curl -d "{\\"service_id\\" : \\"${MAIN_SRV_ID}\\"}" -H "Content-Type:application/json" --silent --url /api/security/access/admin/token`
 ACC_TOKEN=`echo $MAIN_ACC_TOKEN | jq -c -r .tokenValue`
 MC_TOKEN_FULL=`curl -s -X POST -d "username=${int_Artifactory_user}" -d 'scope=applied-permissions/user' -d 'audience=jfmc@*' -d 'expires_in=3600' -d 'grant_type=client_credentials'  -H "Authorization: Bearer ${ACC_TOKEN}" ${BASEURL}/access/api/v1/oauth/token`
 MC_TOKEN=`echo $MC_TOKEN_FULL | jq -c -r .access_token`
 JPDS=`curl --silent -X GET -H "Authorization: Bearer ${MC_TOKEN}" ${BASEURL}/mc/api/v1/jpds`
 JPD_VALUES=`echo $JPDS | jq -c -r -s '.[] | map_values({  "url": .url, "id": .id})'`
 TARGET_JPDS=`echo $JPD_VALUES | jq -c  '. | map (. | select (.id != "JPD-1"))'`
 echo `curl -X PUT -d "{\\"entities\\" : [\\"USERS\\",\\"GROUPS\\",\\"PERMISSIONS\\",\\"TOKENS\\"], \\"targets\\" : ${TARGET_JPDS} }" -H "Content-Type:application/json" -H "Authorization: Bearer ${MC_TOKEN}" ${BASEURL}/mc/api/v1/federation/JPD-1`
######################
# End of Access Federartion
#######################


#######################
# Start generating GPG Key for Distribution
#######################


 mkdir gpg
 chmod 700 gpg
 gpg --homedir gpg --list-keys
 cat >keydetails <<EOF
    %echo Generating a GPG key
    Key-Type: RSA
    Key-Length: 2048
    Subkey-Type: RSA
    Subkey-Length: 2048
    Name-Real: jfrog_sample
    Name-Comment: jfrog_sample
    Name-Email: jfrog_sample@acme.com
    Expire-Date: 0
    %no-ask-passphrase
    %no-protection
    %pubring gpg/pubring.kbx
    %secring gpg/trustdb.gpg
    # Do a commit here, so that we can later print "done" :-)
    %commit
    %echo done
EOF
 gpg --batch --gen-key keydetails
 echo -e "5\ny\n" |  gpg --command-fd 0 --homedir gpg  --expert --edit-key jfrog_sample@acme.com trust;
 KEY_ID=`gpg --no-default-keyring --secret-keyring gpg/trustdb.gpg --keyring gpg/pubring.kbx --list-keys | grep -e "^ " |tr -d '[:space:]'`
 PR_KEY=`gpg --armor  --no-default-keyring --secret-keyring gpg/trustdb.gpg --keyring gpg/pubring.kbx --export-secret-keys ${KEY_ID}`
 PU_KEY=`gpg --armor  --no-default-keyring --secret-keyring gpg/trustdb.gpg --keyring gpg/pubring.kbx --export ${KEY_ID}`
 GPG_REQ="{\"key\": { \"public_key\": \"${PU_KEY}\", \"private_key\":\"${PR_KEY}\"}, \"propagate_to_edge_nodes\": true, \"fail_on_propagation_failure\": false }"
 echo "${GPG_REQ}" > thekey.json
 echo "populating Distribution GPG keys"
 echo `curl -X POST -H "Content-Type:application/json" -H "Accept: application/json" -u ${int_Artifactory_user}:${int_Artifactory_apikey} ${BASEURL}/distribution/api/v1/keys/gpg -T thekey.json` 
#######################
# End genearting GPG key for Distribution
#######################
fi

####### create local repos
echo "Creating local repositories"
for file in ${dirName}/*.local; do
  jfrog rt rc ${file}
done
####### create remote repos
echo "Creating remote repositories"
for file in ${dirName}/*.remote; do
  jfrog rt rc ${file}
done
####### create virtual repos
echo "Creating virtual repositories"
for file in ${dirName}/*.virtual; do
  jfrog rt rc ${file}
done
####### create groups
echo "Creating groups"
for file in ${dirName}/*.group; do
  group="$(b=${file##*/}; echo ${b%.*})"
  jfrog rt curl -X PUT -H "Content-Type: application/json" --data "@${file}" /api/security/groups/$group
done
###### create permission targets
echo "Creating permission targets"
for file in ${dirName}/*.permissiontarget; do
  permissionTarget="$(b=${file##*/}; echo ${b%.*})"
  jfrog rt curl -X PUT -H "Content-Type: application/json" --data "@${file}" /api/v2/security/permissions/$permissionTarget
done

for file in ${dirName}/*.policy; do
    policy="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${int_Artifactory_user}:${int_Artifactory_apikey} -X POST --silent -H "Content-Type: application/json" --data "@${file}" ${BASEURL}/xray/api/v2/policies
done

for file in ${dirName}/*.watch; do
    watch="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${int_Artifactory_user}:${int_Artifactory_apikey} -X POST --silent -H "Content-Type: application/json" --data "@${file}" ${BASEURL}/xray/api/v2/watches
done


if [[ "$IS_EPLUS" = "200" ]]
then
 ### creating local repos on the edges
 EDGE_URLS_JSON=`echo ${TARGET_JPDS} | jq -c -r ' map(.url)'`
 for edge_url in $(echo ${TARGET_JPDS} | jq -c -r '.[] | .url');do
 #  EDGE_TOKEN_FULL=`curl -s -X POST -d "username=${int_Artifactory_user}" -d 'scope=applied-permissions/user' -d 'audience=jfrt@*' -d 'expires_in=3600' -d 'grant_type=client_credentials'  -H "Authorization: Bearer ${ACC_TOKEN}" ${BASEURL}/access/api/v1/oauth/token`
 #  EDGE_TOKEN=`echo $EDGE_TOKEN_FULL | jq -c -r .access_token`

  echo "Creating prod local repositories on the edge node ${edge_url}"
  for file in ${dirName}/*prod*.local; do
    jfrog rt rc --user ${int_Artifactory_user} --password ${int_Artifactory_apikey} --url "${edge_url}artifactory"  ${file} 
  done
 done
fi

