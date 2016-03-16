#!/bin/bash
#
# Copyright 2015-2016 Linagora, Université Joseph Fourier, Floralis
#
# The present code is developed in the scope of the joint LINAGORA -
# Université Joseph Fourier - Floralis research program and is designated
# as a "Result" pursuant to the terms and conditions of the LINAGORA
# - Université Joseph Fourier - Floralis research program. Each copyright
# holder of Results enumerated here above fully & independently holds complete
# ownership of the complete Intellectual Property rights applicable to the whole
# of said Results, and may freely exploit it in any manner which does not infringe
# the moral rights of the other copyright holders.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

### BEGIN INIT INFO
# Provides:          roboconf-dm
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: The startup script for Roboconf DM
# Description:       This file should be used to construct scripts to be
#                    placed in /etc/init.d.
### END INIT INFO

# Do NOT "set -e"

RETVAL=0
PATH=/sbin:/usr/sbin:/bin:/usr/bin
NAME=roboconf-dm
PIDFILE=/var/run/$NAME.pid

# Set environment variables for the DM
export KARAF_HOME=/opt/roboconf-dm
export KARAF_BASE=/opt/roboconf-dm
export KARAF_ETC=/etc/roboconf-dm
export KARAF_DATA=/var/lib/roboconf-dm
export JAVA_HOME=/usr/lib/jvm/jre


start() {
        RETVAL=0
        echo "Starting $NAME... "
        if [ ! -f $PIDFILE ]; then
            cd ${KARAF_HOME}/bin && ./start
	        echo $! > $PIDFILE
	        RETVAL=$?
	        echo "Done."
        else
            echo "Karaf is considered as already running since $PIDFILE exists."
            echo "Please, consider using 'status' and/or 'restart'."
        fi

        return $RETVAL
}

stop() {
        echo "Shutting down $NAME..."
        RETVAL=$?
        
        if [ -f $PIDFILE ]; then
        	cd ${KARAF_HOME}/bin && ./stop
        	rm -f $PIDFILE
        else
        	echo "Karaf is not considered as already running since $PIDFILE exists."
            echo "Searching for PIDs to kill savagely..."

            ROBOCONF_DM_PIDS=`ps aux | grep roboconf-dm | grep -v stop | grep -v restart | grep -v grep | awk '{print $2}' `
            for pid in $ROBOCONF_DM_PIDS
            do
                echo "Killing process $pid..."
                kill -9 $pid
            done;
        fi

        echo "Done."
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
        cd ${KARAF_HOME}/bin && ./status
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $NAME {start|stop|status|restart}"
        exit 1
        ;;
esac
exit $RETVAL
