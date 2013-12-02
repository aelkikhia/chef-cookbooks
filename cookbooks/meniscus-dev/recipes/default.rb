#
# Cookbook Name:: meniscus-dev
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'git'


#update app definitions
execute "apt-get update" do
  command "apt-get update"
  action :run
end

#install C dependencies for pylognorm
package "libestr-dev" do
  action :install
end

package "libee-dev" do
  action :install
end

package "liblognorm-dev" do
  action :install
end

directory node['meniscus']['installdir'] do
  owner vagrant
  mode "0755"
  action :create
end

git "#{node['meniscus']['installdir']}/#{node['meniscus']['branch']}" do
  repository node['meniscus']['repo']
  reference node['meniscus']['branch']
  action :sync
  user vagrant
end