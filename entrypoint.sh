#!/bin/bash

# Mount Google Drive using Rclone
/mount-gdrive.sh &

# Wait a bit to ensure the mount is ready
sleep 5

# Start Jellyfin
exec /jellyfin/jellyfin "$@"
