#!/bin/bash
# *****************************************************
# backup.sh
# What it does: Creates a compressed backup archive
# How to run: ./scripts/backup.sh <source> <dest>
# Example: ./scripts/backup.sh /var/www /backups
# *****************************************************
set -euo pipefail

SOURCE="${1:?ERROR: Please provide a source folder. Usage: $0 <source> <destination>}"
DEST="${2:?ERROR: Please provide a destination folder. Usage: $0 <source> <destination>}"

# Create a timestamp like: 20260322_201500
DATE=$(date '+%Y%m%d_%H%M%S')

# Build the archive filename
ARCHIVE="${DEST}/backup_$(basename $SOURCE)_${DATE}.tar.gz"
echo "[$(date '+%T')] Starting backup..."
echo " Source folder: $SOURCE"
echo " Save to: $DEST"
echo " Archive name: $(basename $ARCHIVE)"
echo ""

# Create the destination folder if it does not exist
mkdir -p "$DEST"

# Check the source folder actually exists
if [ ! -d "$SOURCE" ]; then
echo "ERROR: Source folder does not exist: $SOURCE"
exit 1
fi

# Create the compressed archive
tar -czf "$ARCHIVE" "$SOURCE"
# Show the file size of what we just created
SIZE=$(du -sh "$ARCHIVE" | cut -f1)
echo " SUCCESS!"
echo " Archive size: $SIZE"
echo "[$(date '+%T')] Backup complete."
