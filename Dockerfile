FROM centos:latest
MAINTAINER RJY<renjunyu@foxmail.com>

RUN yum install -y wget unzip openssl-devel gcc swig python python-devel python-setuptools autoconf libtool libevent git ntpdate
RUN yum install -y m2crypto automake make curl curl-devel zlib-devel perl perl-devel cpio expat-devel gettext-devel
RUN easy_install supervisor
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz && \
    tar zxf LATEST.tar.gz && \
    cd libsodium* && \
    ./configure && make -j2 && make install && \
    ldconfig && \
    cd .. && \
    rm -rf LATEST.tar.gz && \
    rm -rf libsodium*
RUN mkdir -p /var/log/supervisor
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git /etc/shadowsocks
ADD kcptun /usr/bin/kcptun
ADD shadowsocks.json /etc/shadowsocks.json
RUN chmod +x /usr/bin/kcptun
ADD supervisord.conf /etc/supervisord.conf

ENV SS_PASSWORD=123456 SS_PORT=666 SS_METHOD=CHACHA20 KCP_PORT=45445 KCP_MTU=1400 KCP_SNDWND=2048 KCP_RCVWND=2048 KCP_MODE=fast2
ENV SS_PROTOCOL=auth_sha1_v2 SS_OBFS=tls1.2_ticket_auth
#set port

EXPOSE $SS_PORT/tcp
EXPOSE $SS_PORT/udp
EXPOSE $KCP_PORT/udp
  
#run supervisor
CMD ["/usr/bin/supervisord"]
