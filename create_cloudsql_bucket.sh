#!/bin/sh
source env.sh

gsutil mb gs://$CLOUDSQL_BUCKET
touch empty.sql
gsutil cp empty.sql gs://$CLOUDSQL_BUCKET
