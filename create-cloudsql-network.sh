#!/bin/sh
source env.sh

PROJECT=$(gcloud config get-value project)
gcloud compute networks create $CLOUDSQL_NETWORK \
--bgp-routing-mode='global' \
--description="cloudsql network" \
--subnet-mode=custom

gcloud compute firewall-rules \
create allow-db-network \
--network $CLOUDSQL_NETWORK \
--allow \
tcp:0-65535,udp:0-65535,icmp \
--source-ranges 10.128.2.0/28

gcloud compute addresses create cloudsql-peering \
    --global \
    --purpose=VPC_PEERING \
    --addresses=10.128.0.0 \
    --prefix-length=20 \
    --description=DBRange \
    --network=$CLOUDSQL_NETWORK


gcloud beta services vpc-peerings connect \
    --service=servicenetworking.googleapis.com \
    --ranges=cloudsql-peering \
    --network=$CLOUDSQL_NETWORK \
    --project=$PROJECT