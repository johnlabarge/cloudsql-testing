#!/bin/sh
source env.sh

gcloud compute ssh --zone=$SYSBENCH_ZONE $SYSBENCH_INSTANCE --command=\
'bash -c "cd /opt/sysbench-scripts && \
 sudo ./createdb.sh"'
 