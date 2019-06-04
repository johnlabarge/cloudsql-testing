#!/bin/bash
source env.sh

# run asynchronously and get job ID for subsequent polling
CLOUDSQL_JOB_ID=$(\
gcloud beta sql instances create $CLOUDSQL_MASTER \
  --database-version=MYSQL_5_7 \
  --enable-bin-log \
  --region=$CLOUDSQL_MASTER_REGION \
  --network=$CLOUDSQL_NETWORK \
  --async \
  --format="value(name)" \
)
# wait for operation to complete (sometimes takes a while)
gcloud beta sql operations wait --project $PROJECT $CLOUDSQL_JOB_ID

gcloud sql users set-password root --instance=$CLOUDSQL_MASTER --password=$MASTER_PASSWORD --host=%

gcloud beta sql users create $REPLICATOR_USER --instance=$CLOUDSQL_MASTER --password=$REPLICATOR_PASSWORD
