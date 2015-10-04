#!/bin/sh - 
 
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/opt/local/bin:/usr/local/bin 
log=/var/log/rsync.Xsan.log.`date -u ''+%y-%m-%d''` 

date > $log 

echo "START rsync Xsan" >> $log 
/usr/bin/rsync --avP --exclude=".DS_Store" --stats --ignore-errors -h --dry-run "/Volumes/XSAN/MEDIA/" "/Volumes/XsanBKUP/MEDIA/" >> $log
/usr/bin/rsync --avP --exclude=".DS_Store" --stats --ignore-errors -h --dry-run "/Volumes/XSAN/PHOTOS/" "/Volumes/XsanBKUP/PHOTOS/" >> $log

echo "END rsync Xsan" >> $log 

date >> $log

echo "Xsan backup DONE" |mail -s "Xsan backup DONE" example@domain.com
