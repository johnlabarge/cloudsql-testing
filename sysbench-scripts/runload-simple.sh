#!/bin/bash
source env.sh
sysbench \
--test=/usr/share/doc/sysbench/tests/db/oltp.lua \
--mysql-host=$MASTER \
--mysql-port=3306 \
--mysql-user=loaduser \
--mysql-password=loaduser123 \
--mysql-db=sbtest \
--mysql-table-engine=innodb \
--oltp-tables-count=50 \
--oltp-table-size=1000000 \
--max-requests=0 \
--num-threads=8 \
--report-interval=10 \
--report-checkpoints=10 \
run
EOF
