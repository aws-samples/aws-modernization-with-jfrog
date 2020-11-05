#!/bin/bash 
export LC_ALL=C
export NG_CLI_ANALYTICS=ci

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

echo "Creating xray policies"
for file in ${dirName}/*.policy; do
    policy="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${jfrog_user}:${jfrog_apikey} -X POST --silent -H "Content-Type: application/json" --data "@${file}" ${BASEURL}/xray/api/v2/policies
done

echo "Creating xray watches"
for file in ${dirName}/*.watch; do
    watch="$(b=${file##*/}; echo ${b%.*})"
    curl -u ${jfrog_user}:${jfrog_apikey} -X POST --silent -H "Content-Type: application/json" --data "@${file}" ${BASEURL}/xray/api/v2/watches
done

echo "Resizing Cloud9 environment"
sh scripts/resize_c9.sh 20
