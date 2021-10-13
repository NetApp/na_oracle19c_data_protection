#/usr/bin/sh
# Description: Shutdown database and relink Oracle binary.
# The script search Oracle databases in /etc/oratab file in "running mode or Y" and
# loop through each database on target server to shutdown each DB relink binary for each Oracle home.

ORATAB=/etc/oratab
if [ ! -f $ORATAB ]
then
        exit 1
fi

log=`date +"%Y%m%d%H%M"`.log

grep ".*:.*:Y" /etc/oratab | while read line 
do
  ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
  ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
  export ORACLE_SID
  export ORACLE_HOME
  export PATH=$PATH:$ORACLE_HOME/bin
  export SCRIPT_DIR=/tmp
  $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF>> $log
    whenever sqlerror exit SQL.SQLCODE
    shutdown abort;
    exit;
EOF
  $ORACLE_HOME/bin/lsnrctl stop listener.$ORACLE_SID 
  cd $ORACLE_HOME/bin
  ./relink
done
