#!/bin/bash
############################################################################
# Copyright 2014-2015 Linagora, Université Joseph Fourier, Floralis
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
############################################################################

. ./conf.sh


# Released with Roboconf ${project.version}.
# Do not edit further, unless you know exactly what to change.
scp $SSH_OPTIONS $AGENT_TAR_LOC ubuntu@$IP_AGENT:
echo "The agent was successfully uploaded."



# Connect to the agent VM
ssh -t $SSH_OPTIONS ubuntu@$IP_AGENT bash <<ENDOFSCRIPT

# Install Java
sudo apt-get update -y
sudo apt-get install openjdk-7-jdk -y

# Extract the agent
rm -rf $AGENT_NAME
tar -xf $AGENT_NAME.tar.gz

# Configure it
cd $AGENT_NAME/etc
sed -i "s/target-id = /target-id = $TARGET_ID/g" net.roboconf.agent.configuration.cfg
sed -i "s/message-server-ip = localhost/message-server-ip = $IP_RMQ/g" net.roboconf.agent.configuration.cfg
sed -i "s/message-server-username = guest/message-server-username = $RMQ_USER/g" net.roboconf.agent.configuration.cfg
sed -i "s/message-server-password = guest/message-server-password = $RMQ_PWD/g" net.roboconf.agent.configuration.cfg

cd ../bin
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre" >> setenv

# Start Karaf
echo "Starting Karaf..."
./start
sleep 20

# Configure it
echo "Trying to configure Karaf..."
./client -u karaf "feature:install service-wrapper"
./client -u karaf "wrapper:install -n roboconf-agent"

./stop
sleep 20

# Register it as a service
sudo ln -s /home/ubuntu/roboconf-karaf-dist-agent-$VERSION/bin/roboconf-agent-service /etc/init.d/
sudo update-rc.d roboconf-agent-service defaults

exit
ENDOFSCRIPT

echo "Installation and configuration of the agent completed successfully."
echo "The agent will start on the next reboot of the VM. You can also create an image of it."
