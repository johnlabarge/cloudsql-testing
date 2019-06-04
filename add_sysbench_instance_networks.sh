#!/bin/sh
source env.sh
gcloud sql instances patch $CLOUDSQL_MASTER --authorized-networks=$(testerIpInternal),$(testerIpExternal),$(replicaIpOutgoing),$(replicaIpExternal) --quiet
gcloud sql instances patch $CLOUDSQL_REPLICA --authorized-networks=$(testerIpExternal),$(testerIpExternal),$(masterIpInternal),$(masterIpExternal) --quiet

