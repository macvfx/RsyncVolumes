#!/bin/bash

# Check if LucidLink FileSpace is mounted
# Use rsync to copy everything EXCEPT large movie files. 
# 
# Note 1: Edit rsync exclude as needed
#
# Note 2: Edit name of LucidLink FileSpace and destination for rsync

# Define source and destination
SOURCE="/Volumes/LucidLinkFileSpace/"
DESTINATION="/Volumes/Backup/Folder"
LOG=/var/log/rsync.LucidLink.log.$(date -u ''+%y-%m-%d'') 

date > "$LOG"

# Check if the volume is mounted
if mount | grep -q "Lucid@lucidfs0"; then
    # Check if it's mounted with specific options
    if mount | grep "Lucid@lucidfs0" | grep -q "lucidfs, local, synchronous"; then
        # Execute rsync command with logging
        rsync -avP --stats --exclude={'*.mxf','*.MXF','*.MOV','*.mov','*.MP4','*.mp4'} "$SOURCE" "$DESTINATION" >> "$LOG" 2>&1
    else
        echo "Volume is mounted but does not have the expected options."
    fi
else
    echo "Volume is not mounted."
fi
