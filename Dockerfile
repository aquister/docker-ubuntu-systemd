FROM ubuntu:16.04

ENV container docker
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

RUN systemctl set-default multi-user.target

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD ["/sbin/init"]
