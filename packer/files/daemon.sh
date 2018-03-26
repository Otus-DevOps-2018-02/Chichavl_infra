#!/bin/bash

PIDFILE="/home/appuser/reddit/puma.pid"
STARTCOMMAND="puma -d"
APPNAME="Reddit Monolith App"
APPDIR="/home/appuser/reddit"

usage() {
    echo "Usage: daemon.sh {start|stop|restart}"
}

if [[ -z ${PIDFILE} ]]; then
    PID=$(cat ${PIDFILE})
fi

start() {
    echo "Starting ${APPNAME}"
    if [[ -z "APPDIR" ]]; then
        cd ${APPDIR}
    fi
    ${STARTCOMMAND} & echo $! > ${PIDFILE}
}

stop() {
    if [[ -z "${PID}" ]]; then
        echo "${APPNAME} is not running (missing PID)."
    elif [[ -e /proc/${PID}/exe ]]; then
        kill ${PID} & rm ${PID}
    else
        echo "${APPNAME} is not running (tested PID: ${PID})."
    fi 
}

case "$1" in
    start)
        start;
        ;;
    restart)
        stop; sleep 1; start;
        ;;
    stop)
        stop
        ;;
    *)
        usage
        exit 4
        ;;
esac