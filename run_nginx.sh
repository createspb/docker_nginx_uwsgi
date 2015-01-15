#!/bin/bash

# replace wsgi backend address with env vars values
/bin/sed -i "s/server<uwsgi_server_placeholder>/${WEB_PORT_44000_TCP_ADDR}:${WEB_PORT_44000_TCP_PORT}/" /etc/nginx/conf.d/service.conf

# set up auth
if [ -n "${BASIC_USER}" -a -n "${BASIC_PASS}" ]; then
    echo -n "${BASIC_USER}:" > /etc/nginx/passwd
    openssl passwd "${BASIC_PASS}" >> /etc/nginx/passwd
else
    echo -n "admin:" > /etc/nginx/passwd
    openssl passwd "admin" >> /etc/nginx/passwd
fi

# now start nginx
exec nginx