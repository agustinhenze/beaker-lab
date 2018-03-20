#!/bin/bash

for i in $(seq 25 -1 1); do
    echo "Starting beaker lab controller in ${i} seconds..."
    sleep 1s
done

echo "Starting beaker lab controller"

set -eux

sed -i "s@HUB_URL =.*@HUB_URL = \"${HUB_URL}\"@g" /etc/beaker/labcontroller.conf
sed -i "s@USERNAME =.*@USERNAME = \"${BEAKER_USER}\"@g" /etc/beaker/labcontroller.conf
sed -i "s@PASSWORD =.*@PASSWORD = \"${BEAKER_PASS}\"@g" /etc/beaker/labcontroller.conf

sed -i 's@disable.*yes@disable     = no@g' /etc/xinetd.d/tftp

echo "ServerName $(hostname -f)" > /etc/httpd/conf.d/global-server-name.conf

cat > /etc/beaker/client.conf << EOF
HUB_URL = "${HUB_URL}"
AUTH_METHOD = "password"
USERNAME = "${BEAKER_USER}"
PASSWORD = "${BEAKER_PASS}"
EOF

httpd -k start

if ! bkr labcontroller-list | grep ${HOSTNAME}; then
    bkr labcontroller-create --fqdn=$(hostname -f) -u ${BEAKER_USER} -p ${BEAKER_PASS} -e root@$(hostname)
fi

nohup beaker-proxy -f &

nohup beaker-watchdog -f &

nohup beaker-provision -f &

xinetd

set +x

while true; do
    sleep 10s
done
