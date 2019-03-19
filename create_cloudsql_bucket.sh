#!/bin/sh
gsutil mb $CLOUDSQL_BUCKET
touch empty.sql
gsutil cp empty.sql $CLOUDSQL_BUCKET

