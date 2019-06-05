#!/bin/bash
source env.sh

gcloud compute instances create $SYSBENCH_INSTANCE --zone=$SYSBENCH_ZONE --metadata-from-file startup-script=sysbench_init.sh

