#!/bin/bash

# 1. Copy Maven settings on the VM.
# 2. Upload artifacts to Sonatype.
# 3. Use -q option to only display Maven errors and warnings.
# 4. Use --settings to force the usage of our "settings.xml" file.

wget http://roboconf.net/resources/build/settings.xml
mvn clean deploy -DskipTests=true -q --settings settings.xml
