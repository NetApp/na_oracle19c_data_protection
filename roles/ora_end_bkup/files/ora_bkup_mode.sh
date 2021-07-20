#/usr/bin/sh
# Description: Change Oracle database backup mode before and after ONTAP snapshots
# The script search Oracle databases in /etc/oratab file in "running mode or Y" and
# loop through each database on target server to turn on or off backup mode given mode variable $1 passed in.

ORATAB=/etc/oratab
if [ ! -f $ORATAB ]
then
        exit 1
fi

log=`date +"%Y%m%d%H%M"`.log

case "$1" in
'begin_bkup')
   grep ".*:.*:Y" /etc/oratab | while read line
   do
     ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
     ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
     echo $ORACLE_SID
     echo $ORACLE_HOME
     export PATH=$PATH:$ORACLE_HOME/bin
     which sqlplus
     $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF>> $1_$log
     whenever sqlerror exit SQL.SQLCODE
     alter system archive log current;
     alter database begin backup;
     exit;
EOF
   done
   ;;

'end_bkup')
   grep ".*:.*:Y" /etc/oratab | while read line;
   do
     ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
     ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
     export ORACLE_SID
     export ORACLE_HOME
     export PATH=$PATH:$ORACLE_HOME/bin
     $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF>> $1_$log
     whenever sqlerror exit SQL.SQLCODE
     alter database end backup;
     exit;
EOF
   done
   ;;
esac
