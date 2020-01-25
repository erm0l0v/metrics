FROM python:3.8.1-alpine3.11

RUN mkdir -p /var/log/nginx/ && \
    mkdir -p /var/log/gunicorn/ && \
    apk update && \
    apk add nginx --no-cache && \
    apk add supervisor --no-cache && \
    apk add openrc --no-cache && \
    pip install gunicorn==18.0 && \
    pip install supervisor supervisor-stdout

ADD ./www /www
ADD ./conf/supervisord.conf /etc/supervisord.conf
ADD ./conf/nginx.conf /etc/nginx/nginx.conf

RUN nginx -t

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

EXPOSE 80

