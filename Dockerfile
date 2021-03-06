FROM alpine:latest
MAINTAINER debuggerboy

#ENV PATH /app/mistserver:$PATH
ENV MISTSERVERSRC=https://github.com/DDVTECH/mistserver/archive/2.13.tar.gz

# install basics
RUN apk --no-cache update
RUN apk --no-cache add ca-certificates wget nano vim bash file binutils musl-utils libstdc++ libgcc cmake git make gcc musl-dev g++ mbedtls-dev libexecinfo-dev
RUN mkdir -p /src/mistserver /config /media

# install mistserver
RUN wget -qO- ${MISTSERVERSRC} | tar xvz -C /src/mistserver
RUN cd /src/mistserver/mistserver-2.13 && cmake . && make && make install

# clean up
RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME /config /media
EXPOSE 4242 8181 1935 554

#CMD ["MistController -c /config/server.conf"]
#CMD ['echo "n" | /usr/bin/MistController -c /config/server.conf']
CMD ["/bin/bash", "-c", "echo 'n' | /usr/bin/MistController -c /config/server.conf"]
