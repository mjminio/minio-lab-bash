#!/bin/bash

## Create folder structure
echo -e ${G}"Creating file structure..."${E}
sudo mkdir -m 777 -p /mnt/data
sudo mkdir -p /home/$MINIO_USER/minio/misc/registry
sudo mkdir -p /home/$MINIO_USER/minio/tools/deploy/docker/docker-compose/single
sudo mkdir -p /home/$MINIO_USER/minio/tools/deploy/docker/docker-compose/distributed
sudo mkdir -p /home/$MINIO_USER/minio/tools/deploy/native/
sudo mkdir -p /home/$MINIO_USER/minio/tools/deploy/mc/
sudo mkdir -p /home/$MINIO_USER/minio/tools/deploy/k8s/operator/
sudo chmod 0777 -R /home/$MINIO_USER/minio/

