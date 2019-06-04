#!/bin/sh
source env.sh
gcloud sql instances patch $CLOUDSQL_MASTER --authorized-networks=$(testerIpExternal),$(replicaIpInternal) --quiet
gcloud sql instances patch $CLOUDSQL_REPLICA --authorized-networks=$(testerIpExternal),$(masterIpInternal) --quiet

