#!/bin/bash

# replace wsgi backend address with env vars values
/bin/sed -i "s/server<uwsgi_server_placeholder>/${WEB_PORT_44000_TCP_ADDR}:${WEB_PORT_44000_TCP_PORT}/" /etc/nginx/conf.d/service.conf

# now start nginx
exec nginx
