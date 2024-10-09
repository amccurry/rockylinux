FROM rockylinux/rockylinux:9
ENV container=docker

RUN dnf update -y
RUN dnf swap -y coreutils-single coreutils
RUN dnf swap -y curl-minimal curl
RUN dnf group install -y Server

COPY bin /opt/installer/bin
RUN /opt/installer/bin/install.sh
STOPSIGNAL SIGRTMIN+3
CMD ["/usr/sbin/init"]
