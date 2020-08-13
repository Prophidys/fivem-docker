FROM alpine:edge

ARG TAG=2556
ARG COMMIT=20c9ba6af577a55f07444cf4858ae4db35f6e375

RUN apk add --no-cache curl ca-certificates

# add fivem repositories
RUN curl --http1.1 -sLo /etc/apk/keys/peachypies@protonmail.ch-5adb3818.rsa.pub https://runtime.fivem.net/client/alpine/peachypies@protonmail.ch-5adb3818.rsa.pub

RUN echo https://runtime.fivem.net/client/alpine/builds >> /etc/apk/repositories
RUN echo https://runtime.fivem.net/client/alpine/main >> /etc/apk/repositories
RUN echo https://runtime.fivem.net/client/alpine/testing >> /etc/apk/repositories
RUN echo https://runtime.fivem.net/client/alpine/community >> /etc/apk/repositories
RUN apk --no-cache update

RUN apk add --no-cache curl=7.63.0-r99 libssl1.1 libunwind libstdc++ zlib c-ares icu-libs v8 musl-dbg execline

RUN mkdir /opt/resources

WORKDIR /tmp

RUN curl -O https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${TAG}-${COMMIT}/fx.tar.xz
RUN tar xvf fx.tar.xz
RUN cp -r alpine/opt/cfx-server /opt/cfx-server
RUN rm -rf /tmp/*

WORKDIR /opt

ENTRYPOINT ["exec", "/opt/cfx-server/ld-musl-x86_64.so.1", "--library-path", "/usr/lib/v8/:/lib/:usr/lib/", "/opt/cfx-server/FXServer", "+set", "citizen_dir", "/opt/cfx-server/citizen/", "+exec", "/opt/resources/server.cfg"]
