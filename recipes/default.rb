#
# Cookbook Name:: cookbook-h2o
# Recipe:: default
#
# Copyright (C) 2015 Peter Helenefors
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'git'
#include_recipe 'cmake'

package 'cmake make gcc g++ libyaml-dev libssl-dev pkg-config'

git '/usr/src/h2o' do
  repository 'https://github.com/h2o/h2o.git'
  revision 'master'
  action :sync
end

execute 'cmake -DCMAKE_INSTALL_PREFIX=/usr/local .' do
	cwd '/usr/src/h2o'
end
execute 'make' do
	cwd '/usr/src/h2o'
end
execute 'sudo make install' do
	cwd '/usr/src/h2o'
end

directory "/etc/h2o"
directory "/var/log/h2o"

template '/etc/h2o/h2o.conf'
template '/etc/init.d/h2o' do
	source 'init_d_h2o.erb'
end

file '/etc/ssl/certs/h2o.crt'
file '/etc/ssl/private/h2o.key'

file '/etc/ssl/certs/h2o_alternate.crt'
file '/etc/ssl/private/h2o_alternate.key'

execute 'update-rc.d h2o defaults'

service 'h2o' do
	action [:start, :enable]
end