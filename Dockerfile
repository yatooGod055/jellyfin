# Base image
FROM jellyfin/jellyfin:latest

# Install required packages and Rclone
RUN apt-get update && apt-get install -y \
    curl unzip fuse3 && \
    curl https://rclone.org/install.sh | bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up Rclone configuration
COPY rclone.conf /root/.config/rclone/rclone.conf

# Create and copy mount script
COPY mount-gdrive.sh /mount-gdrive.sh
RUN chmod +x /mount-gdrive.sh

# Create and copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Jellyfin default port
EXPOSE 8096

# Use the custom entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
