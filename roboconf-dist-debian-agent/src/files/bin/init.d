#!/bin/sh
#
#  Copyright 2014 Linagora, Université Joseph Fourier
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
#

### BEGIN INIT INFO
# Provides:          roboconf-agent
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: The startup script for Roboconf agent
# Description:       This file should be used to construct scripts to be
#                    placed in /etc/init.d.
### END INIT INFO

#
# Author: Vincent ZURCZAK <vincent.zurczak@linagora.com>
#

# Do NOT "set -e"

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Roboconf Agent"
NAME=roboconf-agent
DAEMON=/opt/roboconf-agent/bin/karaf
SCRIPTNAME=/etc/init.d/$NAME
RUNDIR=/var/run/$NAME
PIDFILE=/var/run/$NAME.pid

export KARAF_HOME=/opt/roboconf-agent
export KARAF_BASE=/opt/roboconf-agent
export KARAF_ETC=/etc/roboconf-agent
export KARAF_DATA=/var/lib/roboconf-agent

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions


#
# Function that starts Roboconf agent as a daemon
#
do_start_karaf_agent()
{
	# Return
	#   0 if daemon has been started
	#   1 if daemon was already running
	#   2 if daemon could not be started
	start-stop-daemon --start --quiet --background --make-pidfile --pidfile $PIDFILE --startas $DAEMON --test > /dev/null \
		|| return 1
	start-stop-daemon --start --quiet --background --make-pidfile --pidfile $PIDFILE --startas $DAEMON \
		|| return 2
}

do_stop_karaf_agent()
{
	# Return
	#   0 if daemon has been stopped
	#   1 if daemon was already stopped
	#   2 if daemon could not be stopped
	#   other if a failure occurred
	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE
	RETVAL="$?"
	[ "$RETVAL" = 2 ] && return 2
	rm -f $PIDFILE
	return "$RETVAL"
}

#
# Function that sends a SIGHUP to the daemon/service
#
do_reload() {
	#
	# If the daemon can reload its configuration without
	# restarting (for example, when it is sent a SIGHUP),
	# then implement that here.
	#
	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
	return 0
}

case "$1" in
  start)
	[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC"
	do_start_karaf_agent
	;;
  stop)
	[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC"
	do_stop_karaf_agent
	;;
  status)
   status_of_proc "/usr/bin/java" "$NAME" && exit 0 || exit $?
   ;;
  #reload|force-reload)
	#
	# If do_reload() is not implemented then leave this commented out
	# and leave 'force-reload' as an alias for 'restart'.
	#
	#log_daemon_msg "Reloading $DESC"
	#do_reload
	#log_end_msg $?
	#;;
  restart|force-reload)
	#
	# If the "reload" option is implemented then remove the
	# 'force-reload' alias
	#
	log_daemon_msg "Restarting $DESC"
	do_stop_karaf_agent
	case "$?" in
	  0|1)
		do_start_karaf_agent
		case "$?" in
			0) log_end_msg 0 ;;
			1) log_end_msg 1 ;; # Old process is still running
			*) log_end_msg 1 ;; # Failed to start
		esac
		;;
	  *)
	  	# Failed to stop
		log_end_msg 1
		;;
	esac
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac
