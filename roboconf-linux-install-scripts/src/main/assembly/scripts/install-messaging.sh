#!/bin/sh
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
ssh -t $SSH_OPTIONS ubuntu@$IP_RMQ bash <<ENDOFSCRIPT

# Install the last version
sudo echo deb http://www.rabbitmq.com/debian/ testing main >> /etc/apt/sources.list
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get install rabbitmq-server -y

# Create a configuration script
rm -f ~/configure-rmq.sh
echo "rabbitmqctl add_user $RMQ_USER $RMQ_PWD" > ~/configure-rmq.sh
echo "rabbitmqctl set_permissions $RMQ_USER \".*\" \".*\" \".*\"" >> ~/configure-rmq.sh
echo "rabbitmqctl delete_user guest" >> ~/configure-rmq.sh

# Execute it now...
sudo chmod 755 ~/configure-rmq.sh
sudo ~/configure-rmq.sh

# ... and make it executed at every boot (if not already done).
# This is useful when we create an image from the RabbitMQ VM.
# No need to reconfigure every time (BTW, this is related to IP changes).
if ! grep -q configure-rmq.sh /etc/rc.local; then
	sudo sed -i "s/^exit 0/~\/configure-rmq.sh\nexit 0/g" /etc/rc.local
fi

exit
ENDOFSCRIPT

echo "Installation and configuration of RabbitMQ completed successfully."
