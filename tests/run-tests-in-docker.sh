#!/bin/bash

RETVAL=0
CAUSE=""

LOC=`dirname "$(readlink -f "$0")"`
RBCF_RESULTS=/tmp/roboconf-results
mkdir -p $RBCF_RESULTS
rm -rf $RBCF_RESULTS/*



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
