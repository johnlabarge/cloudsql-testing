#!/bin/bash
source env.sh
cat > createLoad.sql <<EOF
create database sbtest;

CREATE USER 'loaduser'@'%' IDENTIFIED BY 'loaduser123';

GRANT ALL PRIVILEGES ON * . * TO 'loaduser'@'%';

FLUSH PRIVILEGES;
EOF
mysql -uroot -p$MASTER_PASSWORD -h $MASTER < createLoad.sql