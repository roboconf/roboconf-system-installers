#!/bin/sh
############################################################################
# Copyright 2014-2016 Linagora, Université Joseph Fourier, Floralis
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

# These scripts were written for Ubuntu 14.x.
# Released with Roboconf ${project.version}.
# Update these parameters. You should not have to modify the others scripts.


############################################################################
# The IP address of the VM to host RabbitMQ.
IP_RMQ=

# The IP address of the VM to host the agent (used to create a template image).
IP_AGENT=

# The IP address of the VM to host the DM.
# Required only if you use the "install-dm.sh" script.
# Local DM installations do not need it.
IP_DM=

# The file for SSH connections on the VMs.
PEM_LOC=~/.ssh/your.pem

# The Roboconf version (e.g. 0.2-SNAPSHOT).
VERSION=${project.version}

# The credentials for RabbitMQ
RMQ_USER=roboconf
RMQ_PWD=roboconf


############################################################################
# The names and locations of the DM and agent archives
DM_NAME=roboconf-karaf-dist-dm-$VERSION
DM_TAR_LOC=~/.m2/repository/net/roboconf/roboconf-karaf-dist-dm/$VERSION/$DM_TAR_LOC.tar.gz

AGENT_NAME=roboconf-karaf-dist-agent-$VERSION
AGENT_TAR_LOC=~/.m2/repository/net/roboconf/roboconf-karaf-dist-agent/$VERSION/$AGENT_NAME.tar.gz


############################################################################
# The target ID (used to configure the agent).
# Tested targets: EC2, Openstack
TARGET_ID=iaas-ec2


############################################################################
# SSH options
SSH_OPTIONS="-i $PEM_LOC -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
