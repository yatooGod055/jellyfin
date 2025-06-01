#!/bin/bash

# Define variables
RCLONE_CONFIG="/root/.config/rclone/rclone.conf"  # Path to Rclone config
MOUNT_POINT="/mnt/gdrive"                         # Mount location
LOG_FILE="/var/log/rclone.log"                   # Log file for Rclone
RCLONE_REMOTE="gdrive:"                          # Remote name in Rclone config

# Ensure the mount point exists
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point at $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# Unmount if already mounted (to avoid conflicts)
if mountpoint -q "$MOUNT_POINT"; then
    echo "Unmounting existing mount at $MOUNT_POINT"
    fusermount -u "$MOUNT_POINT"
fi

# Mount Google Drive using Rclone
echo "Mounting Google Drive to $MOUNT_POINT"
rclone mount $RCLONE_REMOTE "$MOUNT_POINT" \
    --config "$RCLONE_CONFIG" \
    --vfs-cache-mode writes \
    --allow-other \
    --dir-cache-time 5m \
    --poll-interval 1m \
    --log-level INFO \
    --log-file "$LOG_FILE" \
    --daemon

# Wait to ensure the mount is successful
sleep 5

# Check if the mount was successful
if mountpoint -q "$MOUNT_POINT"; then
    echo "Google Drive successfully mounted at $MOUNT_POINT"
else
    echo "Failed to mount Google Drive. Check $LOG_FILE for details."
    exit 1
fi
