#!/bin/bash 

# Set default directory to /var/log if no directory provided
LOGDIR="${1:-/var/log}"

# check the directory exists
if [ ! -d "$LOGDIR" ]; then
	echo "'$LOGDIR' is not a valid directory" >&2
	exit 1
fi 

# go into dir
cd "$LOGDIR"

# create timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# make folder to place archive
ARC_DIR="/usr/archives"
mkdir -p "$ARC_DIR"

# name of archive
ARC_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# create arcchive
tar -cvzf "$ARC_DIR/$ARC_NAME" "$LOGDIR"

# file for keeping log of archive creation
LOG_FILE="/usr/archives.log"

echo "$(date) - created archive of $LOGDIR in $ARC_DIR/$ARC_NAME" >> "$LOG_FILE"

# clear the $LOG_DIR if archive created successfully

if [ $? -eq 0 ]; then
  echo "Archive created successfully. Clearing logs in $LOGDIR..."
  find "$LOGDIR" -type f -name '*.log' -exec truncate -s 0 {} \;
else
  echo "Failed to create archive. Logs not deleted." >&2
fi
