#!/bin/bash
set -e
set +x
if [ -z "${VOLUME_ROOT}" ] ; then
  exec -a init /usr/sbin/init
fi
mkdir -p ${VOLUME_ROOT}/opt/desktop/
rsync -a /opt/desktop/ ${VOLUME_ROOT}/opt/desktop/
/opt/desktop/sbin/copy-root.sh ${VOLUME_ROOT}
mount -o bind /dev ${VOLUME_ROOT}/dev
mount -o bind,ptmxmode=0666 /dev/pts ${VOLUME_ROOT}/dev/pts
mount -o bind /proc ${VOLUME_ROOT}/proc
mount -o bind /sys ${VOLUME_ROOT}/sys
mount -o bind /etc/resolv.conf ${VOLUME_ROOT}/etc/resolv.conf
mount -o bind /etc/hosts ${VOLUME_ROOT}/etc/hosts
mount -o bind /etc/hostname ${VOLUME_ROOT}/etc/hostname
exec -a init /opt/desktop/sbin/chroot_entrypoint /usr/sbin/init
