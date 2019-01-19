if [[ $# -ne 1 ]]
  then
     printf "\nusage: $0 [start/stop]\n\n"
     exit 0
fi

PID_FILE=/tmp/my_dummy_exporter.py.py_pid
SCRIPT_BASE_NAME=my_dummy_exporter
SCRIPT_LOCATION=./
SCRIPT=${SCRIPT_LOCATION}/${SCRIPT_BASE_NAME}.py
export LOG_DIR=/var/log
export LOG_BASE_NAME=my_dummy_exporter
export LOG_NAME=${LOG_DIR}/${LOG_BASE_NAME}.log
export EXPORTER_PORT=65433


checkError(){
  if [ $1 -ne 0 ]
   then
    echo "$2"
    exit $1
  fi
}

getPID(){
  PID=`cat ${PID_FILE} 2>/dev/null`
  if [[ "${PID}" == "" ]]
   then 
    echo "-1"
  else 
    echo "${PID}"
  fi
}

checkPort(){
  running=`netstat -tl | grep -i "tcp" | grep ${EXPORTER_PORT} | wc -l`
  checkError ${running} "port '${EXPORTER_PORT}' already taken, please check"
}

fail_if_process_running(){
  RUNNING_PID=`getPID`
  RUNNING=`ps aux|awk '{print $11}' |grep -v grep |grep ${SCRIPT_BASE_NAME}|wc -l `
  checkError ${RUNNING} "${SCRIPT_BASE_NAME} already running pid=${RUNNING_PID} "
  checkPort
}


case $1 in 
  "start" )  fail_if_process_running 
             ${SCRIPT} >> ${LOG_NAME}  2>&1 &
             echo $! > $PID_FILE
             while true; do
             sleep 1
             done;;
  "stop" )  PID=`getPID`
            echo "stopping..... `ps -ef|grep $PID|grep -v grep|grep ${SCRIPT_BASE_NAME}`"
            kill $PID
            echo "stopped"  ;;
  * ) printf "\nusage: $0 [start/stop]\n\n"  ;; 
esac
