FROM centos:latest
MAINTAINER RJY<renjunyu@foxmail.com>

RUN yum -y install python-setuptools && easy_install supervisor && easy_install shadowsocks

RUN mkdir -p /var/log/supervisor

RUN yum install -y wget
RUN wget ftp://admin:renjunyu@ren.renjunyu.cn/AiDisk_a1/ftp/kcptun -O /usr/bin/kcptun
RUN chmod +x /usr/bin/kcptun
ADD supervisord.conf /etc/supervisord.conf
ADD config.json /etc/config.json

#set port
EXPOSE 8989/tcp
EXPOSE 8989/udp
EXPOSE 29900/udp
  
#run supervisor
CMD ["/usr/bin/supervisord"]
