#!/bin/bash

source .vars

set -e
G="\e[32m"
E="\e[0m"

if ! grep -q 'Ubuntu' /etc/issue
  then
    echo -----------------------------------------------
    echo "Not Ubuntu? Could not find Codename Ubuntu in lsb_release -a. Please switch to Ubuntu."
    echo -----------------------------------------------
    exit 1
fi

##  Prerequisites on each server
echo "Installing Prereqs..."
scripts/prereqs.sh &
wait

## Install Minio Lab components
echo "Installing Minio Lab components..."
scripts/lab-server.sh &
wait

## Print Server Information and Links
# touch ./server-details.txt
# echo -----------------------------------------------
# echo -e ${G}Install is complete. Please use the below information to access your environment.${E} | tee ./server-details.txt
# echo -e ${G}-----Code Server Details-----${E}
# echo -e ${G}Code Server UI:${E} https://code.$PROXY_IP.nip.io | tee -a ./server-details.txt
# echo -e ${G}Code Server Login${E} $CODE_PASSWORD | tee -a ./server-details.txt
# echo -e ${G}-----Rancher Details-----${E}
# echo -e ${G}Rancher UI:${E} https://rancher.$PROXY_IP.nip.io | tee -a ./server-details.txt
# echo -e ${G}Rancher Login:${E} admin/$RANCHER_PASSWORD | tee -a ./server-details.txt
# echo -e ${G}-----Portainer Details-----${E}
# echo -e ${G}Portainer UI:${E} https://portainer.$PROXY_IP.nip.io | tee -a ./server-details.txt
# echo -e ${G}Portainer Login:${E} admin/$PORTAINER_PASSWORD | tee -a ./server-details.txt
# echo -e ${G}-----Proxy Status Page Details - Use For Troubleshooting-----${E}
# echo -e ${G}HAProxy UI:${E} https://$PROXY_IP.nip.io/stats/ | tee -a ./server-details.txt
# echo -e ${G}HAProxy Login:${E} admin/$HAPROXY_PASSWORD | tee -a ./server-details.txt
# echo Details above are saved to the file at ./server-details.txt
# echo -----------------------------------------------
