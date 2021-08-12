#/usr/bin/sh
# Description: Restore Oracle databases to specified recovery point: a scn, or a time stamp after a snapshot restore.
# The script search Oracle databases in /etc/oratab file in "running mode or Y" and
# loop through each database on target server to complete an incomplete recovery and reset log file to open the databases. 

ORATAB=/etc/oratab
if [ ! -f $ORATAB ]
then
        exit 1
fi

log=`date +"%Y%m%d%H%M"`.log

case "$1" in
'scn')
   grep ".*:.*:Y" /etc/oratab | while read line
   do
     ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
     ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
     export ORACLE_SID
     export ORACLE_HOME
     export PATH=$PATH:$ORACLE_HOME/bin
     $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF>> $1_$log
     whenever sqlerror exit SQL.SQLCODE
     shutdown abort;
     startup mount;
     recover database until change $2 using backup controlfile;
     alter database open resetlogs;
     exit;
EOF
   done
   ;;

'time')
   grep ".*:.*:Y" /etc/oratab | while read line;
   do
     ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
     ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
     export ORACLE_SID
     export ORACLE_HOME
     export PATH=$PATH:$ORACLE_HOME/bin
     $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF>> $1_$log
     whenever sqlerror exit SQL.SQLCODE
     shutdown abort;
     startup mount;
     recover database until time '$2' using backup controlfile;
     alter database open resetlogs;
     exit;
EOF
   done
   ;;
esac
