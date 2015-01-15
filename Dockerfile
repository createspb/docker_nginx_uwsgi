FROM phusion/baseimage:0.9.15

MAINTAINER Vladimir Shulyak <vladimir@shulyak.net>

RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list

ADD /nginx_signing.key /tmp/nginx_signing.key
RUN apt-key add /tmp/nginx_signing.key
RUN apt-get update
RUN apt-get install -y nginx=1.7.*


# Nginx service
RUN mkdir /etc/service/nginx
ADD run_nginx.sh /etc/service/nginx/run
RUN chmod 755 /etc/service/nginx/run


ADD /service.conf /etc/nginx/conf.d/service.conf

# nginx gotta be in foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

RUN sed -i '/    sendfile        on;/a     client_max_body_size 100m;' /etc/nginx/nginx.conf

EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*