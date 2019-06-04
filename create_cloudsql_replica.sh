#!/bin/bash
source env.sh

MASTER_IP=$(masterIpExternal)
REPRESENTATION="$CLOUDSQL_MASTER-$CLOUDSQL_REPLICA-representation"
echo "Creating representation for SQL Master: $MASTER_IP"

gcloud beta sql instances create $REPRESENTATION \
--region=$CLOUDSQL_REPLICA_REGION \
--database-version=MYSQL_5_7 \
--source-ip-address=$MASTER_IP \
--source-port=3306

echo "Creating Replica under $REPRESENTATION"

# run asynchronously and get job ID for subsequent polling
CLOUDSQL_JOB_ID=$(\
gcloud beta sql instances create $CLOUDSQL_REPLICA \
    --master-instance-name=$REPRESENTATION \
    --region=$CLOUDSQL_REPLICA_REGION \
    --master-username=$REPLICATOR_USER \
    --master-password=$REPLICATOR_PASSWORD\
    --master-dump-file-path=gs://$CLOUDSQL_BUCKET/empty.sql \
    --async \
    --format="value(name)" \
)

# wait until the replica has an IP address assigned
REPLICA_IP=$(replicaIpOutgoing)
while [ "x$REPLICA_IP" == "x" ] ; do
	echo "Waiting for Replica IP..."
	sleep 10
	REPLICA_IP=$(replicaIpOutgoing)
done

# patch the existing configs in the master to allow the new replica to continue connecting, using its "outgoing IP address"
# NOTE: this will replace any existing authorized-network configs!
gcloud sql instances patch $CLOUDSQL_MASTER --authorized-networks=$REPLICA_IP --quiet

gcloud beta sql operations wait --project $PROJECT $CLOUDSQL_JOB_ID


# FIXME: wait for replica setup to complete
gcloud sql users set-password root --instance=$CLOUDSQL_REPLICA --password=$MASTER_PASSWORD --host=%


