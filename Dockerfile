#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:20.04

LABEL maintainer "Nguyen Manh"
LABEL email="nguyenmanh0397@gmail.com"

# Update the package list and install davfs2 vs unison
RUN apt-get update \
  && apt-get install -y davfs2 ca-certificates unison \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN mkdir -p /mnt/source \
    && mkdir -p /mnt/webdrive

ENV TZ Asia/Ho_Chi_Minh

# COPY ./configs/davfs2.conf /etc/davfs2/davfs2.conf
COPY ./configs/default.prf /root/.unison/default.prf

COPY ./start-sync.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-sync.sh

ENTRYPOINT [ "/usr/local/bin/start-sync.sh" ]

