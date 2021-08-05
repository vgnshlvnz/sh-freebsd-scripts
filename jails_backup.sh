#!/bin/sh -x

stop_jails="/usr/sbin/service jail stop  > /root/jail_backup.log"
start_jails="/usr/sbin/service jail start >> /root/jail_backup.log"


daily_www_backup="/bin/sh -c '/usr/local/bin/rsync -av /usr/jails/www /root/rsync/daily' >> /root/www_jail_backup.log"
delete_old_www_residue="/bin/sh -c '/usr/local/bin/rsync -av --delete /usr/jails/www /root/rsync/daily' >> /root/www_jail_backup.log"
delete_old_residue_weekly="/bin/sh -c '/usr/local/bin/rsync -av --delete /root/rsync/daily /root/rsync/weekly' >> /root/jail_backup.log"
daily_mysql_backup="/bin/sh -c '/usr/local/bin/rsync -av /usr/jails/mysql /root/rsync/daily' >> /root/mysql_jail_backup.log"
delete_old_mysql_residue="/bin/sh -c '/usr/local/bin/rsync -av --delete /usr/jails/mysql /root/sync/daily' >> /root/mysql_jail_backup.log"


eval "$stop_jails"
eval "$daily_www_backup"

if [ $? -eq 0 ]
then
        echo 'success' >> /root/www_jail_backup.log
else
        echo 'faili' >> /root/www_jail_backup.log
fi


eval "$daily_mysql_backup"

if [ $? -eq 0 ]
then
        echo 'success' >> /root/mysql_jail_backup.log
else
        echo 'fail' >> /root/mysql_jail_backup.log
fi


eval "$delete_old_www_residue"
eval "$delete_old_mysql_residue"
eval "$start_jails"

eval "$delete_old_residue_weekly"
