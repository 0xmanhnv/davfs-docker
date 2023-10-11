#!/bin/bash

#Check veriables or set defaults
if [ -z ${WEBDRIVE_USER} ]; then
  echo "Webdrive user is not set"
fi

if [ -z ${WEBDRIVE_PASSWORD} ]; then
  echo "Webdrive password is not set"
fi

if [ -z ${WEBDRIVE_URL} ]; then
  echo "Webdrive url is not set"
fi

SYNC_USERID=${SYNC_USERID:-0} # User Own folder mounted

echo "$WEBDRIVE_URL $WEBDRIVE_USER $WEBDRIVE_PASSWORD" >> /etc/davfs2/secrets
echo "$WEBDRIVE_URL /mnt/source davfs user,rw,auto 0 0" >> /etc/fstab
echo "use_locks 0" >> /etc/davfs2/davfs2.conf

# Create user
if [ $SYNC_USERID -gt 0 ]; then
  useradd webdrive -u $SYNC_USERID -N -G users
fi

# Mount the webdaf drive with root
# mount -t davfs $URL /mnt/source -o uid=$FOLDER_USER,gid=users,dir_mode=755,file_mode=755
mount -t davfs -o uid=$SYNC_USERID,gid=users,dir_mode=755,file_mode=755 $WEBDRIVE_URL /mnt/source

# Start the endless sync process
unison