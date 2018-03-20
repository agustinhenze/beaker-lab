#!/bin/bash

for i in $(seq 20 -1 1); do
    echo "Starting beaker server in ${i} seconds..."
    sleep 1s
done

echo "Starting beaker server"

set -eux

sed -i 's/beaker@localhost/beaker@db/g' /etc/beaker/server.cfg

echo "ServerName $(hostname)" > /etc/httpd/conf.d/global-server-name.conf

httpd -k start

beaker-init -u ${BEAKER_USER} -p ${BEAKER_PASS} -e root@$(hostname)

# it's broken for now ¯\_(ツ)_/¯
#nohup beakerd -f &

set +x

while true; do
    sleep 10s
done
