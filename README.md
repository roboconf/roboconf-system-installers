# Roboconf's System Installers
[![License](https://img.shields.io/hexpm/l/plug.svg)](http://www.apache.org/licenses/LICENSE-2.0)

Website: [http://roboconf.net](http://roboconf.net)  
Licensed under the terms of the **Apache License v2**.

The sources for system installers.  
This includes Linux scripts, Debian packages, etc.
  
They are located in a different Git repository because for a given version of Roboconf,
there may be several released installers. Said differently, fixing something in an installer
does not mean the binaries (e.g. the platform) have to be changed.


## Testing Protocol

For RPM packages, we run tests in Docker on 2 distributions.

```
docker pull centos
LOC=workspace/roboconf-system-installers/.../RPMS/noarch
docker run -v $LOC:/tmp/docker-shared -it centos /bin/bash
``` 

Then, with the DM as an example...

```
# Installation
yum install java-1.7.0-openjdk
cd /tmp/docker-shared
yum install roboconf-dm-\*.rpm

# Verification.
# The DM should be running.
/etc/init.d/roboconf-dm status
more /var/run/roboconf.pid

# Stop, restart, start...
# /var/run/roboconf.pid shoudl only exists when the DM is started.
/etc/init.d/roboconf-dm restart
 
# Verify the logging configuration.
more /etc/roboconf-dm/org.ops4j.pax.logging.cfg
ls /var/log/roboconf-dm 
```

Same thing with Fedora.

```
docker pull fedora
# ...
```

For Debian packages, we proceed the same way with Debian...

```
docker pull debian
# ...
```

... and with Debian packages instead of RPM.  
In all cases, both the agent and the DM should be tested.
