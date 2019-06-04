#!/bin/bash
source env.sh


gcloud compute ssh --zone=$SYSBENCH_ZONE $SYSBENCH_INSTANCE --command=\
'bash -c "cd /opt/sysbench-scripts && \
sudo /opt/sysbench-scripts/make_prepare.sh && \
sudo chmod 775 prepare.sh &&
./prepare.sh"'
