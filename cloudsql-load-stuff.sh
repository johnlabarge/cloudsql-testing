#!/bin/bash
source env.sh
gcloud compute ssh $SYSBENCH_INSTANCE --command='sudo bash -c "cd /opt/sysbench-scripts && \
./make_runload-stuff.sh && \
./runload-stuff.sh"'