#!/bin/bash
source env.sh
gcloud beta sql instances create $CLOUDSQL_MASTER \
  --database-version=MYSQL_5_7 \
  --enable-bin-log \
  --region=$CLOUDSQL_MASTER_REGION \
  --network=$CLOUDSQL_NETWORK

gcloud sql users set-password root --instance=$CLOUDSQL_MASTER --password=$MASTER_PASSWORD --host=%

gcloud beta sql users create $REPLICATOR_USER --instance=$CLOUDSQL_MASTER --password=$REPLICATOR_PASSWORD