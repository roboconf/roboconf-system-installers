# Roboconf's System Installers
[![Build Status](http://travis-ci.org/roboconf/roboconf-system-installers.png?branch=master)](http://travis-ci.org/roboconf/roboconf-system-installers/builds)
[![License](https://img.shields.io/hexpm/l/plug.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![Join us on Gitter.im](https://img.shields.io/badge/gitter-join%20chat-brightgreen.svg)](https://gitter.im/roboconf/roboconf)
[![Web site](https://img.shields.io/badge/website-roboconf.net-b23e4b.svg)](http://roboconf.net)

[![Snapshots](https://img.shields.io/badge/Snapshots%20on-Sonatype-orange.svg)](https://oss.sonatype.org/content/repositories/snapshots/net/roboconf/)
[![Snapshots](https://img.shields.io/badge/Snapshots%20on-Bintray-orange.svg)](https://bintray.com/roboconf)
[![Bintray](https://img.shields.io/badge/Releases%20on-Bintray-yellow.svg)](https://bintray.com/roboconf)

<img src="http://roboconf.net/resources/img/nn-0.4-debian-packages-for-roboconf.jpg" alt="Debian packages for Roboconf" width="300" />

<img src="http://roboconf.net/resources/img/nn-0.7-rpm-packages-for-roboconf.jpg" alt="RPM packages for Roboconf" width="400" />

The sources for system installers.  
This includes Linux scripts, Debian packages, RPMs, etc.
  
They are located in a different Git repository because for a given version of Roboconf,
there may be several released installers. Said differently, fixing something in an installer
does not mean the binaries (e.g. the platform) have to be changed.


## Build

```
mvn clean install
```


## Test

Automated tests are based on Docker and scripts.  
They are supposed to be executed on Linux.

```
./tests/run-tests-in-docker.sh
```
