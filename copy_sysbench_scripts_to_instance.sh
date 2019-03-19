#!/bin/sh
source env.sh
MASTER_IP=$(gcloud sql instances describe $CLOUDSQL_MASTER --format="value(ipAddresses[0].ipAddress)" | tail -1)
REPLICA_IP=$(gcloud sql instances describe $CLOUDSQL_REPLICA --format="value(ipAddresses[0].ipAddress)" | tail -1)

cat <<EOF >sysbench-scripts/env.sh 
export MASTER=$MASTER_IP
export REPLICA=$REPLICA_IP
export MASTER_PASSWORD=$MASTER_PASSWORD
EOF

tar -czf sysbench-scripts.tar.gz sysbench-scripts
gcloud compute scp sysbench-scripts.tar.gz $SYSBENCH_INSTANCE:/tmp
gcloud compute ssh $SYSBENCH_INSTANCE --command=\
'bash -c "sudo cp /tmp/sysbench-scripts.tar.gz /opt && \
cd /opt && sudo tar -xzf /opt/sysbench-scripts.tar.gz && \
sudo chmod -R 775 /opt/sysbench-scripts"'
