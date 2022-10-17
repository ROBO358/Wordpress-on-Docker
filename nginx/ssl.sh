#! /bin/sh

mkdir -p /etc/nginx/templates
touch /etc/nginx/templates/default.conf.template
cat /tmp/default.conf.tmp > /etc/nginx/templates/default.conf.template

source /docker-entrypoint.sh nginx -g "daemon off;" &

while [ ! -e /cert_done/true ]
do
    sleep 1
    echo "wait for certbot"
done

nginx -s stop

wait

cat /tmp/ssl.conf.tmp >> /etc/nginx/templates/default.conf.template

source /docker-entrypoint.sh nginx -g "daemon off;" &

while :
do
    sleep 12h
    echo "nginx reload"
    nginx -s reload
done
