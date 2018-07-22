FROM ubuntu:16.04

ENV container docker
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV LANG en_US.UTF-8
ENV PATH "${PATH}:/opt/puppetlabs/bin"

RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

RUN systemctl set-default multi-user.target
RUN apt-get update
RUN apt-get install -y \
  git wget vim iputils-ping net-tools jq locales sudo \
  build-essential apt-transport-https dnsutils unzip

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD ["/sbin/init"]
