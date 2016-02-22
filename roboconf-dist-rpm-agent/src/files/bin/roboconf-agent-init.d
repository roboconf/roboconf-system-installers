#!/bin/bash
#
#  Copyright 2015-2016 Linagora, Université Joseph Fourier
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# Source function library.

. /lib/lsb/init-functions
RETVAL=0
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Roboconf Agent"
NAME=roboconf-agent
DAEMON=/opt/roboconf-agent/bin/karaf

PIDFILE=/var/run/$NAME.pid
# Set environment variables for Roboconf-agent
export KARAF_HOME=/opt/roboconf-agent
export KARAF_BASE=/opt/roboconf-agent
export KARAF_ETC=/etc/roboconf-agent
export KARAF_DATA=/var/lib/roboconf-agent
export JAVA_HOME=/usr/lib/jvm/jre
# Declare variables for roboconf-agent
ROBOCONF_AGENT_DIR=/opt/roboconf-agent


start() {
        echo -n "Starting $NAME: "
        start_daemon $DAEMON  &
        echo $! > $PIDFILE
        RETVAL=$?
        echo
        return $RETVAL
}

stop() {
        echo -n "Shutting down $NAME: "
        RETVAL=$?
        rm -f $PIDFILE
        ROBOCONF_AGENT_PIDS=`ps aux | grep roboconf-agent |grep -v stop | grep -v grep | awk '{print $2}' `
        for pid in $ROBOCONF_AGENT_PIDS
        do
                kill -9 $pid
        done;
        echo
        return $RETVAL
}


case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        . /etc/init.d/functions && status -p $PIDFILE $NAME
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $prog {start|stop|status|restart}"
        exit 1
        ;;
esac
exit $RETVAL
