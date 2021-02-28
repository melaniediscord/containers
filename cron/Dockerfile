FROM clearlinux:base
RUN swupd bundle-add rclone
ENV XDG_CONFIG_HOME=/config

CMD rclone sync -Pv --transfers 8 /data $TARGET_REMOTE --backup-dir=$BACKUP_DIR --suffix $SUFFIX $EXTRA_OPTIONS
