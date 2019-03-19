#!/bin/bash
source env.sh
cat > prepare.sh <<EOF
#!/bin/bash
source env.sh
sysbench \\
--test=/usr/share/doc/sysbench/tests/db/parallel_prepare.lua \\
--oltp-tables-count=50 \\
--oltp_table_size=1000000 \\
--mysql-host=$MASTER \\
--mysql-port=3306 \\
--mysql-user=loaduser \\
--mysql-password=loaduser123 \\
--mysql-table-engine=innodb \\
--num-threads=8 \\
--report-interval=1 \\
--report-checkpoints=10 \\
--tx-rate=300 run
EOF
