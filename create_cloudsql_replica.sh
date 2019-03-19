#!/bin/sh
source env.sh
CLOUDSQL_MASTER_REPRESENTATION="$CLOUDSQL_MASTER-representation"
BUCKET_URL="gs://$CLOUDSQL_BUCKET"
MASTER_IP=$(gcloud sql instances list --filter="name:$CLOUDSQL_MASTER" --format="value(ipAddresses[0].ipAddress)" | tail -1)
REPRESENTATION="$CLOUDSQL_MASTER-$CLOUDSQL_REPLICA-representation"
echo $MATER_IP
gsutil mb $BUCKET_URL
touch empty.sql
gsutil cp empty.sql $BUCKET_URL
gcloud beta sql instances create $REPRESENTATION \
--region=$CLOUDSQL_REPLICA_REGION \
--database-version=MYSQL_5_7 \
--source-ip-address=$MASTER_IP \
--source-port=3306

gcloud beta sql instances create $CLOUDSQL_REPLICA \
    --master-instance-name=$REPRESENTATION \
    --master-username=$REPLICATOR_USER \
    --master-password=$REPLICATOR_PASSWORD\
    --master-dump-file-path=gs://$CLOUDSQL_BUCKET/empty.sql

REPLICA_IP=$(gcloud sql instances list --filter="name:$CLOUDSQL_REPLICA" --format="value(ipAddresses[1].ipAddress)" | tail -1)
gcloud sql instances patch $CLOUDSQL_MASTER --authorized-networks=$REPLICA_IP --quiet
gcloud sql users set-password root --instance=$CLOUDSQL_REPLICA --password=$MASTER_PASSWORD --host=%


