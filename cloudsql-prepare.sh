#!/bin/sh
source env.sh


gcloud compute ssh $SYSBENCH_INSTANCE --command=\
'bash -c "cd /opt/sysbench-scripts && \
sudo /opt/sysbench-scripts/make_prepare.sh && \
sudo chmod 775 prepare.sh &&
./prepare.sh"'
