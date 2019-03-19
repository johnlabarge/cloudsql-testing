# CLOUDSQL CROSS-REGION REPLICATION SETUP 
This repo has setup scripts to setup a cross region replication for cloudsql using the external replica setup: https://cloud.google.com/sql/docs/mysql/replication/replication-from-external.

## Prerequisits
GCP Project with billing account

## Test Scripts
First edit the env.sh to customize the setings for your master replication and testing VM.
The scripts should be run in the following order:
1. create_cloudsql_network.sh
1. create_cloudsql_master.sh
1. create_cloudsql_bucket.sh
1. create_cloudsql_replica.sh
1. create_sysbench_instance.sh
1. create_sysbench_scripts_to_instance.sh
1. add_sysbench_instance_network.sh
1. copy_sysbench_scripts_to_instance.sh
1. cloudsql-testdb.sh
1. cloudsql-prepare.sh

## Verifying Replication
Login to the the testing instance

gcloud compute ssh $SYSBENCH_INSTANCE --command='source /opt/sysbench-scripts/env.sh && \
mysql -uroot -p$MASTER_PASSWORD -h$MASTER  -e "use sbtest; select count(*) from sbtest7"'
gcloud compute ssh $SYSBENCH_INSTANCE --command='source /opt/sysbench-scripts/env.sh && \
mysql -uroot -p$MASTER_PASSWORD -h$REPLICA  -e "use sbtest; select count(*) from sbtest7"'

This verifies replication across region for CloudSQL 
TODO - MASTER DEMOTION/PROMOTION
