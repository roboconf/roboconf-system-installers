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

# Constants
readonly PID=/var/run/roboconf-dm.pid
# FILE is an environment variable



# Functions
findPids() {
	echo $(ps aux | grep roboconf | grep -v stop | grep -v restart | grep -v grep | grep -v "/bin/bash /tmp/roboconf-test-scripts/")
}

ok() {
	echo "$1" >> "/tmp/roboconf-results/$FILE.txt"
}

error() {
	echo "error" > "/tmp/roboconf-results/$FILE-failure.txt"
	ok "$1"
}



# Initialization
RETVAL=0



# No Roboconf DM running
echo "Verifying no Roboconf is running..."
if [ -n "$(findPids)" ]; then
	RETVAL=1
	error "Roboconf should NOT be listed in processes. [1]"
fi

if [ -f $PID ]; then
	RETVAL=1
	error "The PID file should NOT exist. [1]"
fi



# Install the DM
echo "Installing Roboconf..."
yum install -y /tmp/docker-shared/roboconf*.rpm
sleep 2



# Verify its is running
echo "Verifying Roboconf is really running..."
if [ -z "$(findPids)" ]; then
	RETVAL=1
	error "Roboconf should be listed in processes. [1]"
fi

if [ ! -f $PID ]; then
	RETVAL=1
	error "The PID file should exist. [1]"
fi



# Verify the logging files
echo "Checking the log files..."
if [ ! -f "/var/log/roboconf-dm/roboconf.log" ]; then
	RETVAL=1
	error "roboconf.log was not found."
fi

if [ ! -f "/var/log/roboconf-dm/karaf.log" ]; then
	RETVAL=1
	error "karaf.log was not found."
fi



# Verify the configuration files
echo "Checking the configuration files..."
if [ ! -f "/etc/roboconf-dm/net.roboconf.dm.configuration.cfg" ]; then
	RETVAL=1
	error "net.roboconf.dm.configuration.cfg was not found under /etc/roboconf-dm."
fi



# Verify the man page
echo "Checking the man page..."
if [ ! -f "/usr/share/man/man1/roboconf-dm.1.gz" ]; then
	RETVAL=1
	error "No man page was found for Roboconf."
fi



# Try to stop it
echo "Stopping Roboconf and making sure everything is as expected..."
/etc/init.d/roboconf-dm stop
sleep 2

if [ -n "$(findPids)" ]; then
	RETVAL=1
	error "Roboconf should NOT be listed in processes. [2]"
fi

if [ -f $PID ]; then
	RETVAL=1
	error "The PID file should NOT exist. [2]"
fi



# Start it again
echo "Starting Roboconf (again) and making sure everything is as expected..."
/etc/init.d/roboconf-dm start
sleep 2

if [ -z "$(findPids)" ]; then
	RETVAL=1
	error "Roboconf should be listed in processes. [2]"
fi

if [ ! -f $PID ]; then
	RETVAL=1
	error "The PID file should exist. [2]"
fi



# Get the PID, restart it and compare with the new PID
OLD_PID_NUMBER=$(<$PID)
echo "Restarting Roboconf..."
/etc/init.d/roboconf-dm restart
sleep 2

if [ -z "$(findPids)" ]; then
	RETVAL=1
	error "Roboconf should be listed in processes. [3]"
fi

if [ ! -f $PID ]; then
	RETVAL=1
	error "The PID file should exist. [3]"
fi

NEW_PID_NUMBER=$(<$PID)
if [ "$OLD_PID_NUMBER" != "$NEW_PID_NUMBER" ]; then
	RETVAL=1
	error "PIDs should be different after a restart."
fi



# Exit the container correctly
if [ "$RETVAL" -eq 0 ]; then
	ok "No error was found while running the tests."
fi

exit 0
