#!/bin/bash

# 1. Upload Debian packages to Bintray.
# The script sequence was (partially) copied from the release scripts.
# The version was already created.

# Constants
readonly BINTRAY_URL="https://bintray.com/api/v1"
readonly VERSION="SNAPSHOT"

# BINTRAY_USER and BINTRAY_API_KEY are provided
# as environment variables by Travis CI.

echo
echo "Updating the package names for Bintray..."
echo

find -name "*+*.deb" -type f | rename 's/\+/_/g'


echo
echo "Resetting the SNAPSHOT version..."
echo

curl -vvf -u${BINTRAY_USER}:${BINTRAY_API_KEY} \
	-X DELETE ${BINTRAY_URL}/packages/roboconf/roboconf-debian-packages-unstable/main/versions/${VERSION}

curl -vvf -u${BINTRAY_USER}:${BINTRAY_API_KEY} -H "Content-Type: application/json" \
	-X POST ${BINTRAY_URL}/packages/roboconf/roboconf-debian-packages-unstable/main/versions \
	--data "{\"name\": \"${VERSION}\", \"github_use_tag_release_notes\": false }"


echo
echo "Uploading the DEB files to Bintray..."
echo

for f in $(find -name "*.deb" -type f)
do
	echo
	echo "Uploading $f"
	curl -X PUT -T $f -u ${BINTRAY_USER}:${BINTRAY_API_KEY} \
		-H "X-Bintray-Debian-Distribution:jessie" \
		-H "X-Bintray-Debian-Component:main" \
		-H "X-Bintray-Debian-Architecture:i386,amd64" \
		-# -o "/tmp/curl-output.txt" \
		${BINTRAY_URL}/content/roboconf/roboconf-debian-packages-unstable/main/${VERSION}/

	echo
	echo "$(</tmp/curl-output.txt)"
	echo
			
	echo "Publishing $f"
	curl -X POST -u ${BINTRAY_USER}:${BINTRAY_API_KEY} \
		-# -o "/tmp/curl-output.txt" \
		${BINTRAY_URL}/content/roboconf/roboconf-debian-packages-unstable/main/${VERSION}/publish
	
	echo
	echo "$(</tmp/curl-output.txt)"
	echo
done



# 2. Upload RPM packages to Bintray.
# The script sequence was (partially) copied from the release scripts.
# The version was already created.

echo
echo "Resetting the SNAPSHOT version..."
echo

curl -vvf -u${BINTRAY_USER}:${BINTRAY_API_KEY} \
	-X DELETE ${BINTRAY_URL}/packages/roboconf/roboconf-rpm-unstable/main/versions/${VERSION}

curl -vvf -u${BINTRAY_USER}:${BINTRAY_API_KEY} -H "Content-Type: application/json" \
	-X POST ${BINTRAY_URL}/packages/roboconf/roboconf-rpm-unstable/main/versions \
	--data "{\"name\": \"${VERSION}\", \"github_use_tag_release_notes\": false }"


echo
echo "Uploading the RPM files to Bintray..."
echo

for f in $(find -name "*.rpm" -type f)
do
	echo
	echo "Uploading $f"
	curl -X PUT -T $f -u ${BINTRAY_USER}:${BINTRAY_API_KEY} \
		-H "X-Bintray-Version:${VERSION}" \
		-H "X-Bintray-Package:main" \
		-# -o "/tmp/curl-output.txt" \
		${BINTRAY_URL}/content/roboconf/roboconf-rpm-unstable/main/${VERSION}/
	
	echo
	echo "$(</tmp/curl-output.txt)"
	echo
	
	echo "Publishing $f"
	curl -X POST -u ${BINTRAY_USER}:${BINTRAY_API_KEY} \
		-# -o "/tmp/curl-output.txt" \
		${BINTRAY_URL}/content/roboconf/roboconf-rpm-unstable/main/${VERSION}/publish
	
	echo
	echo "$(</tmp/curl-output.txt)"
	echo
done
