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
--oltp-test-mode=complex \
--oltp-read-only=off \
--oltp-reconnect=on \
--oltp-tables-count=50 \
--oltp-table-size=1000000 \
--max-requests=100000000 \
--num-threads=8 \
--report-interval=10 \
--report-checkpoints=10 \
--tx-rate=300 \
run
EOF
chmod 775 runload-stuff.sh