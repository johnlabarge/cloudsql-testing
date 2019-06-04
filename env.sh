#!/bin/sh
CLOUDSQL_MASTER=masterdb5 #name you want for cloud sql
CLOUDSQL_MASTER_REGION=us-east1 #region for master
CLOUDSQL_BUCKET="$(gcloud config get-value project)-dbbucket" #name you want for import bucket
CLOUDSQL_REPLICA="replica-db5" #name you want for the replica
CLOUDSQL_REPLICA_REGION=us-central1 #name of region for cloudsql replica
CLOUDSQL_NETWORK=db-network #name for the VPC for Cloud SQL
MASTER_PASSWORD="rootytoot1"
REPLICATOR_USER="replicator"
REPLICATOR_PASSWORD="replicaty!"
SYSBENCH_INSTANCE="sysbenchtester5"
SYSBENCH_ZONE="us-east1-b"

function replicaIp() {
    echo $(gcloud sql instances list --filter="name:$CLOUDSQL_REPLICA" --format="value(ipAddresses[1].ipAddress)" | tail -1)
}

function masterIp() {
    echo $(gcloud sql instances list --filter="name:$CLOUDSQL_MASTER" --format="value(ipAddresses[1].ipAddress)" | tail -1)
}

function testerIp() {
    echo $(gcloud compute instances describe $SYSBENCH_INSTANCE --format="value(networkInterfaces[0].accessConfigs[0].natIP)"  --zone=us-central1-b)
}