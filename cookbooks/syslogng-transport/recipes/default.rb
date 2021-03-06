#
# Cookbook Name:: syslogng-transport
# Recipe:: default
#
# Copyright (C) 2013 Rackspace Hosting
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'libzmq'

package "python-zmq" do
  action :install
end

service "rsyslog" do
  action [ :disable, :stop ]
end

package "syslog-ng" do
  action :install
end

package "syslog-ng-mod-json" do
  action :install
end

remote_file "/etc/syslog-ng/transport_zmq.py" do
  source "https://raw.github.com/ProjectMeniscus/transport/master/transport/transport_zmq.py"
end

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng.conf.erb"
  notifies :restart, "service[syslog-ng]"
end

template "/etc/syslog-ng/modules.conf" do
  source "modules.conf.erb"
  notifies :restart, "service[syslog-ng]"
end

service "syslog-ng" do
  supports :restart => true, :status => true
  action :enable
end

