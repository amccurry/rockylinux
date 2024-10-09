#!/bin/bash
set -ex

# Install XRDP
dnf -y install xrdp tigervnc-server
systemctl enable xrdp.service

# Allow users to login
systemctl enable systemd-user-sessions

# Install Docker
dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/rhel/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker

systemctl mask rtkit-daemon

# Disable Kernel specific servies
# systemctl disable firewalld rtkit-daemon postfix network ksm kdump auditd abrt-oops ksmtuned abrt-ccpp

# systemctl mask ksm rtkit-daemon ksmtuned abrt-ccpp

# Disable and mask plymouth-halt service because of shutdown hang.
# This is a stupid hack to stop the systemd-shutdown from running so that the container can shutdown.
# systemctl disable plymouth-halt
# systemctl mask plymouth-halt
# cp /bin/echo /usr/lib/systemd/systemd-shutdown

# systemctl unmask systemd-logind
