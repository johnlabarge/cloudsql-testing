#!/bin/sh
apt-get update
apt-get install -y xfsprogs sysstat git iotop htop automake libtool libssl-dev make automake default-libmysqlclient-dev mysql-client
echo "installing Percona"
apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys 1C4CBDCDCD2EFD2A
echo "deb http://repo.percona.com/apt $(lsb_release -cs) main" > /etc/apt/sources.list.d/percona.list
apt-get update
apt-get install -y   percona-server-client-5.7  libperconaserverclient20-dev  
cd /opt
git clone https://github.com/Percona-Lab/sysbench.git
chmod -R 755 sysbench
cd sysbench
./autogen.sh
./configure
make install
cp -r sysbench/tests /usr/share/doc/sysbench/
mkdir -p /usr/share/doc/sysbench
chgrp -R adm /usr/share
chmod 775 -R /usr/share/doc/sysbench
