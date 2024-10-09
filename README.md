# Rocky Linux 9 GNOME Desktop

The image contains xrdp for remote access and docker in docker.

## How to build
```
docker build -t local/rl9-systemd systemd/
docker build -t local/rl9-desktop desktop/
```

### Docker in Docker

How to run docker in the desktop:
```
...
-v /sys/fs/cgroup:/sys/fs/cgroup \
--cap-add=NET_ADMIN \
--cap-add=SYS_ADMIN \
...
```

## How to run

### Stateless

This desktop will reset on every startup, normal docker behavior.

```
docker run -d --rm \
  --device /dev/fuse \
  --shm-size=1g \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  --cap-add=SYS_NICE \
  -p 3389:3389 \
  --name desktop \
  local/rl9-desktop
```

### Stateful

This desktop will behavior like a normal desktop and retain changes between restart.

```
export VOLUME_ROOT_NAME=runtime_vdesktop
export VOLUME_ROOT=/runtime_root

docker run -d --rm \
  -e VOLUME_ROOT=${VOLUME_ROOT} \
  -v ${VOLUME_ROOT_NAME}:${VOLUME_ROOT} \
  --device /dev/fuse \
  --shm-size=1g \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  --cap-add=SYS_NICE \
  -p 3389:3389 \
  --stop-signal SIGRTMIN+3 \
  --name desktop \
  desktop
```
