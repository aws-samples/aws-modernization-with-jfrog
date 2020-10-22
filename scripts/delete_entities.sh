#!/bin/bash
export LC_ALL=C

#########################################
# This script deletes local repositories and virtual repository that include all.
#
# Pre-reqs:
#  * need to have available:
#      curl  -- for direct REST invocations
#      jfrog -- the jfrog cli tool
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
repositoryBaseURL="/api/repositories/"
groupsBaseURL="/api/security/groups/"
permsBaseURL="/api/security/permissions/"

####### delete virtual repos
echo "deleting virtual repositories"
for file in ${dirName}/*.virtual; do
    virtual="$(b=${file##*/}; echo ${b%.*.*})"
    virtualURL="${repositoryBaseURL}${virtual}"
    jfrog rt curl -X DELETE ${virtualURL}
done
####### delete local repos
echo "Deleting local repositories"
for file in ${dirName}/*.local; do
    local="$(b=${file##*/}; echo ${b%.*.*})"
    localURL="${repositoryBaseURL}${local}"
    jfrog rt curl -X DELETE ${localURL}
done
####### delete remote repos
echo "Deleting remote repositories"
for file in ${dirName}/*.remote; do
    remote="$(b=${file##*/}; echo ${b%.*.*})"
    remoteURL="${repositoryBaseURL}${remote}"
    jfrog rt curl -X DELETE ${remoteURL}
done
###### delete permission targets
echo "Deleting permission targets"
for file in ${dirName}/*.permissiontarget; do
  permissionTarget="$(b=${file##*/}; echo ${b%.*})"
  permTargetURL="${permsBaseURL}${permissionTarget}"
  jfrog rt curl -X DELETE ${permTargetURL}
done
####### delete groups
echo "Deleting groups"
for file in ${dirName}/*.group; do
  group="$(b=${file##*/}; echo ${b%.*})"
  groupURL="${groupsBaseURL}${group}"
  jfrog rt curl -X DELETE ${groupURL}
done


BASEURL=`jfrog rt curl --silent --url /api/system/configuration | grep urlBase | sed -E 's/.*>(.*)<.*$/\1/'`

IS_EPLUS=`curl -s -w "%{http_code}" -o /dev/null -u ${int_Artifactory_user}:${int_Artifactory_apikey} ${BASEURL}/distribution/api/v1/system/ping`

for file in ${dirName}/*.watch; do
    watch="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${int_Artifactory_user}:${int_Artifactory_apikey} -X DELETE --silent  ${BASEURL}/xray/api/v2/watches/$watch
done
for file in ${dirName}/*.policy; do
    policy="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${int_Artifactory_user}:${int_Artifactory_apikey} -H 'Content-Type:application/json' -X DELETE --silent  ${BASEURL}/xray/api/v2/policies/$policy
done



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

 ### deleting local repos on the edges
 EDGE_URLS_JSON=`echo ${TARGET_JPDS} | jq -c -r ' map(.url)'`
 for edge_url in $(echo ${TARGET_JPDS} | jq -c -r '.[] | .url');do
 #  EDGE_TOKEN_FULL=`curl -s -X POST -d "username=${int_Artifactory_user}" -d 'scope=applied-permissions/user' -d 'audience=jfrt@*' -d 'expires_in=3600' -d 'grant_type=client_credentials'  -H "Authorization: Bearer ${ACC_TOKEN}" ${BASEURL}/access/api/v1/oauth/token`
 #  EDGE_TOKEN=`echo $EDGE_TOKEN_FULL | jq -c -r .access_token`

  echo "Creating prod local repositories on the edge node ${edge_url}"
  for file in ${dirName}/*prod*.local; do
    local="$(b=${file##*/}; echo ${b%.*.*})"
    localURL="${repositoryBaseURL}${local}"
    curl -X DELETE -u ${int_Artifactory_user}:${int_Artifactory_apikey} --url "${edge_url}artifactory${localURL}" 
  done
 done
fi

