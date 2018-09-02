FROM alpine:latest
MAINTAINER debuggerboy

ENV PATH /app/mistserver:$PATH
ENV MISTSERVER=https://github.com/DDVTECH/mistserver/releases/download/2.13/mistserver_Linux_64_2.13.tar.gz

CMD ["/sbin/my_init"]

# install basics
RUN apk --no-cache update
RUN apk --no-cache add ca-certificates wget nano vim bash
RUN mkdir -p /app/mistserver /config /media
ADD start.sh /etc/my_init.d/start.sh
RUN chmod +x /etc/my_init.d/*.sh

# install mistserver
RUN wget -qO- ${MISTSERVER} | tar xvz -C /app/mistserver

# clean up
RUN rm -rf rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME /config /media
EXPOSE 4242 8181 1935 554
