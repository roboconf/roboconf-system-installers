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

RETVAL=0
CAUSE=""

LOC=`dirname "$(readlink -f "$0")"`
RBCF_RESULTS=/tmp/roboconf-results
rm -rf $RBCF_RESULTS
mkdir -p $RBCF_RESULTS



echo
echo "Pulling Docker images..."
echo

docker pull nimmis/java-centos:openjdk-7-jdk
docker pull nimmis/java:openjdk-7-jdk



echo
echo "Testing RPM for the DM (CentOS)..."
echo

docker run \
		-v $LOC:/tmp/roboconf-test-scripts \
		-v "$LOC/../roboconf-dist-rpm-dm/target/rpm/roboconf-dist-rpm-dm/RPMS/noarch":/tmp/docker-shared \
		-v $RBCF_RESULTS:$RBCF_RESULTS \
		--name rpm-dm \
		nimmis/java-centos:openjdk-7-jdk /bin/bash /tmp/roboconf-test-scripts/docker/rpm-dm.sh

docker wait rpm-dm
docker rm rpm-dm

if [ -f "$RBCF_RESULTS/rpm-dm-failure.txt" ]; then
	RETVAL=1
	CAUSE="$CAUSE\nTests for the DM's RPM failed on CentOS."
fi



echo
echo "Testing RPM for the Agent (CentOS)..."
echo

docker run \
		-v $LOC:/tmp/roboconf-test-scripts \
		-v "$LOC/../roboconf-dist-rpm-agent/target/rpm/roboconf-dist-rpm-agent/RPMS/noarch":/tmp/docker-shared \
		-v $RBCF_RESULTS:$RBCF_RESULTS \
		--name rpm-agent \
		nimmis/java-centos:openjdk-7-jdk /bin/bash /tmp/roboconf-test-scripts/docker/rpm-agent.sh

docker wait rpm-agent
docker rm rpm-agent

if [ -f "$RBCF_RESULTS/rpm-agent-failure.txt" ]; then
	RETVAL=1
	CAUSE="$CAUSE\nTests for the Agent's RPM failed on CentOS."
fi



echo
echo "Testing the Debian package for the DM (Ubuntu)..."
echo

docker run \
		-v $LOC:/tmp/roboconf-test-scripts \
		-v "$LOC/../roboconf-dist-debian-dm/target":/tmp/docker-shared \
		-v $RBCF_RESULTS:$RBCF_RESULTS \
		--name debian-dm \
		nimmis/java:openjdk-7-jdk /bin/bash /tmp/roboconf-test-scripts/docker/debian-dm.sh

docker wait debian-dm
docker rm debian-dm

if [ -f "$RBCF_RESULTS/debian-dm-failure.txt" ]; then
	RETVAL=1
	CAUSE="$CAUSE\nTests for the DM's Debian package failed on Ubuntu."
fi



echo
echo "Testing the Debian package for the Agent (Ubuntu)..."
echo

docker run \
		-v $LOC:/tmp/roboconf-test-scripts \
		-v "$LOC/../roboconf-dist-debian-agent/target":/tmp/docker-shared \
		-v $RBCF_RESULTS:$RBCF_RESULTS \
		--name debian-agent \
		nimmis/java:openjdk-7-jdk /bin/bash /tmp/roboconf-test-scripts/docker/debian-agent.sh

docker wait debian-agent
docker rm debian-agent

if [ -f "$RBCF_RESULTS/debian-agent-failure.txt" ]; then
	RETVAL=1
	CAUSE="$CAUSE\nTests for the Agent's Debian package failed on Ubuntu."
fi



echo 
echo "Announcing the verdict..."
echo

if [ "$RETVAL" -ne 0 ]; then
	echo -e "Tests failed.\n$CAUSE"
else
	echo "All the tests succeeded."
fi



echo
echo
echo



echo
echo "Displaying all the test outputs..."
echo

echo "--- RPM for the DM (CentOS) ---"
echo
echo "$(<$RBCF_RESULTS/rpm-dm.txt)"
echo
echo "--- RPM for the Agent (CentOS) ---"
echo
echo "$(<$RBCF_RESULTS/rpm-agent.txt)"
echo
echo "--- Debian package for the DM (Ubuntu) ---"
echo
echo "$(<$RBCF_RESULTS/debian-dm.txt)"
echo
echo "--- Debian package for the Agent (Ubuntu) ---"
echo
echo "$(<$RBCF_RESULTS/debian-agent.txt)"
echo
