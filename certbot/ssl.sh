#! /bin/sh

if [ -d /etc/letsencrypt/live ]; then
    echo "SSL already exists"
else
    echo "SSL does not exist"
    certbot certonly --webroot -w /var/www/html -d www.$NGINX_WP_HOST -d $NGINX_WP_HOST -m $CERTBOT_MAIL --agree-tos -n
fi

touch /cert_done/true

while :
do
    sleep 36h
    echo "Checking SSL"
    certbot renew
done
