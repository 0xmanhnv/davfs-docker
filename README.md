## Refs

- https://github.com/richardregeer/docker-davfs-webdisk/tree/master
- https://manpages.ubuntu.com/manpages/xenial/en/man8/mount.davfs.8.html
- https://seb.so/50gb-of-cloud-space-with-box-automatically-syncd-on-linux-with-webdav/
- https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html


## Build docker image

```bash
docker build -t davfs_docker .
```

```bash
docker run \
--log-opt max-size=10m \
-e WEBDRIVE_USER=<user> \
-e WEBDRIVE_PASSWORD=<password> \
-e WEBDRIVE_URL=<URL> \
-e SYNC_USERID=1001 \
-d \
--privileged \
--device /dev/fuse \
davfs_docker
```