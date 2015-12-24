%define __jar_repack 0
Name: roboconf-dist-rpm-agent
Version: 0.6
Release: SNAPSHOT_1.0_1
Summary: Roboconf :: RPM Package for the Agent
License: (c) null
Group: Applications/Internet
autoprov: yes
autoreq: yes
BuildArch: noarch
BuildRoot: /home/diarraa/git/roboconf-system-installers/roboconf-dist-rpm-agent/target/rpm/roboconf-dist-rpm-agent/buildroot

%description
A solution for elastic deployments

%install

if [ -d $RPM_BUILD_ROOT ];
then
  mv /home/diarraa/git/roboconf-system-installers/roboconf-dist-rpm-agent/target/rpm/roboconf-dist-rpm-agent/tmp-buildroot/* $RPM_BUILD_ROOT
else
  mv /home/diarraa/git/roboconf-system-installers/roboconf-dist-rpm-agent/target/rpm/roboconf-dist-rpm-agent/tmp-buildroot $RPM_BUILD_ROOT
fi
chmod -R +w $RPM_BUILD_ROOT

%files

%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/boot/org.apache.karaf.jaas.boot-4.0.2.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/boot/org.osgi.core-6.0.0.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/boot/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/boot/org.apache.karaf.main-4.0.2.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/endorsed/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/endorsed/org.apache.karaf.exception-4.0.2.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/lib/ext/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/ow2/asm/asm-all/5.0.4/asm-all-5.0.4.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/jledit/core/0.2.1/core-0.2.1.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/ops4j/pax/web/pax-web-features/4.2.2/pax-web-featu"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/ops4j/pax/url/pax-url-aether/2.4.3/pax-url-aether-"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/ops4j/pax/logging/pax-logging-api/1.8.4/pax-loggin"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/ops4j/pax/logging/pax-logging-service/1.8.4/pax-lo"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/karaf/org.apache.karaf.client/4.0.2/org.apa"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/karaf/features/framework/4.0.2/framework-4."
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/karaf/features/standard/4.0.2/standard-4.0."
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/karaf/log/org.apache.karaf.log.core/4.0.2/o"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.ipojo.gogo/1.12.1/or"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.ipojo/1.12.1/org.apa"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.fileinstall/3.5.0/or"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.configadmin/1.8.8/or"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.framework/5.2.0/org."
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/felix/org.apache.felix.ipojo.api/1.12.1/org"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/aries/org.apache.aries.util/1.1.1/org.apach"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/apache/sshd/sshd-core/0.14.0/sshd-core-0.14.0.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/org/slf4j/slf4j-api/1.7.12/slf4j-api-1.7.12.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/jline/jline/2.13/jline-2.13.jar"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-core/0.6-SNAPSHOT/roboconf-core-"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-agent-default/0.6-SNAPSHOT/roboc"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-agent-monitoring/0.6-SNAPSHOT/ro"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-plugin-file/0.6-SNAPSHOT/robocon"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-plugin-puppet/0.6-SNAPSHOT/roboc"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-agent/0.6-SNAPSHOT/roboconf-agen"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-plugin-api/0.6-SNAPSHOT/roboconf"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-plugin-script/0.6-SNAPSHOT/roboc"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-messaging-api/0.6-SNAPSHOT/roboc"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/system/net/roboconf/roboconf-plugin-logger/0.6-SNAPSHOT/roboc"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/start"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/status.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/karaf.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/status"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/stop.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/shell"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/instance.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/setenv"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/instance"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/karaf"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/client.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/shell.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/client"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/start.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/setenv.bat"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/bin/stop"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/data/tmp/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/deploy/README"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.log.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.jaas.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/net.roboconf.agent.configuration.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/distribution.info"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/net.roboconf.messaging.rabbitmq.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/equinox-debug.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/startup.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/jre.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.features.repos.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/keys.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.felix.fileinstall-deploy.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.ops4j.pax.logging.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.kar.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/users.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/profile.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.features.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.management.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/shell.init.script"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.apache.karaf.shell.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/custom.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/config.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/all.policy"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/branding.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/java.util.logging.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/jmx.acl.cfg"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/system.properties"
%attr(755,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.ops4j.pax.url.mvn.cfg"
%attr(755,root,root)  "/etc/init.d/roboconf-agent"
%attr(644,roboconf-agent,roboconf-agent)  "/opt/roboconf-agent/etc/org.ops4j.pax.logging.cfg"

%pre
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
################################################################################
#
# Pre installation script
#
################################################################################

set -e

# Create the system group and user running the Roboconf agent
USER=roboconf-agent
GROUP=roboconf-agent
RPM_SOURCE_DIR=/opt/roboconf-agent/

groups "$GROUP" > /dev/null 2>&1 || groupadd --system "$GROUP"
id "$USER" > /dev/null 2>&1 || adduser --system --no-create-home --gid "$GROUP" "$USER"

#tar -xzvf $RPM_SOURCE_DIR/roboconf-karaf-dist-agent-0.6-SNAPSHOT.tar.gz
#rm $RPM_SOURCE_DIR/roboconf-karaf-dist-agent-0.6-SNAPSHOT.tar.gz

%post
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
################################################################################
#
# Post installation script
#
################################################################################

set -e

# Source debconf library.
#. /usr/share/debconf/confmodule

# The 'roboconf' user was created in the pre-install script
USER=roboconf-agent
GROUP=roboconf-agent

# Create the directory /etc/ directories
ROBOCONF_AGENT_ETC=/etc/roboconf-agent
mkdir -p $ROBOCONF_AGENT_ETC > /dev/null 2>&1 || true
chown $USER:$GROUP $ROBOCONF_AGENT_ETC > /dev/null 2>&1 || true

mv /opt/roboconf-agent/etc/* $ROBOCONF_AGENT_ETC
rmdir /opt/roboconf-agent/etc
chown $USER:$GROUP $ROBOCONF_AGENT_ETC

# Ask for target-id using debconf (see debconf "templates" file),
# then replace target-id in roboconf-agent config (according to user input).
#db_get roboconf-agent/target || true
if [ "$RET" != "other" ]; then
    sed -i "/target-id =/c target-id = $RET" $ROBOCONF_AGENT_ETC/net.roboconf.agent.configuration.cfg
fi

# Create the directory /var/log/roboconf-agent
ROBOCONF_AGENT_VAR_LOG=/var/log/roboconf-agent
mkdir -p $ROBOCONF_AGENT_VAR_LOG > /dev/null 2>&1 || true
chown $USER:$GROUP $ROBOCONF_AGENT_VAR_LOG > /dev/null 2>&1 || true

ROBOCONF_AGENT_VAR_LIB=/var/lib/roboconf-agent
mv /opt/roboconf-agent/data/* $ROBOCONF_AGENT_VAR_LIB
rmdir /opt/roboconf-agent/data
chown $USER:$GROUP $ROBOCONF_AGENT_VAR_LIB

# Register the agent's automatic startup
update-rc.d roboconf-agent defaults

# Start
set +e
if which invoke-rc.d >/dev/null 2>&1; then
   invoke-rc.d --force roboconf-agent start
else
   /etc/init.d/roboconf-agent start
fi


%postun
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
################################################################################
#
# Post uninstallation script
#
################################################################################

set -e

ROBOCONF_AGENT_ETC=/etc/roboconf-agent
ROBOCONF_AGENT_VAR_LOG=/var/log/roboconf-agent
ROBOCONF_AGENT_VAR_LIB=/var/lib/roboconf-agent
ROBOCONF_AGENT_OPT=/opt/roboconf-agent

# Unregister the agent's automatic startup
update-rc.d roboconf-agent remove

if [ "$1" = "purge" ]; then
   # Remove all the work files of the agent
   rm -rf $ROBOCONF_AGENT_VAR_LIB || true
 
   # Remove all the agent config
   rm -rf $ROBOCONF_AGENT_ETC || true
fi
 
# Remove all the log files of the agent
rm -rf $ROBOCONF_AGENT_VAR_LOG || true
# Remove all the executables
rm -rf $ROBOCONF_AGENT_OPT || true   

