#!/bin/sh
source env.sh
gcloud sql instances patch $CLOUDSQL_MASTER --authorized-networks=$(testerIp),$(replicaIp) --quiet
gcloud sql instances patch $CLOUDSQL_REPLICA --authorized-networks=$(testerIp),$(masterIp) --quiet

