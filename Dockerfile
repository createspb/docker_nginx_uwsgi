FROM phusion/baseimage:0.9.17

MAINTAINER Vladimir Shulyak <vladimir@shulyak.net>

RUN add-apt-repository ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y --force-yes nginx=1.8.* && \
    mkdir /etc/service/nginx

# Nginx service
ADD run_nginx.sh /etc/service/nginx/run
ADD /service.conf /etc/nginx/conf.d/service.conf

# nginx gotta be in foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    sed -i '/    sendfile        on;/a     client_max_body_size 100m;' /etc/nginx/nginx.conf && \
    chmod 755 /etc/service/nginx/run && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
