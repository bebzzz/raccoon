#!/bin/bash

DATE=`date +%F-%H%M`
DBNAME='djangodb'
DBPASS='somepassword'
OK=2
load=`uptime | awk '{print $9}' | sed "s/\(.\)\(...,\)/\1/"`

if [ "$load" -lt "$OK" ];
then
   echo "CPU is OK"
   mysqldump ${DBNAME} -uroot -p${DBPASS} > ${DATE}.sql
   AMMOUNT=`ls -la | grep -E '*.\.sql' | wc -l`
   if [ "$AMMOUNT" -gt 7 ];
   then
      TAIL=$(($AMMOUNT - 7))
      echo "MORE THAN 7 DUMPS"
      ls -t | grep -E '*.sql' | tail -n ${TAIL} | xargs rm
   else
      echo ''
   fi
else
   echo "CRITICAL loading"
fi

