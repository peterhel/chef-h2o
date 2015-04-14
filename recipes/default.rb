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

package 'cmake make gcc g++ libyaml-dev libssl-dev pkg-config curl'

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
	mode '0755'
end

remote_directory '/etc/h2o/doc_root' do
  files_mode '0440'
  files_owner 'root'
  mode '0770'
  owner 'root'
  source 'examples/doc_root'
end

remote_directory '/etc/h2o/doc_root.alternate' do
  files_mode '0440'
  files_owner 'root'
  mode '0770'
  owner 'root'
  source 'examples/doc_root.alternate'
end

cookbook_file '/etc/ssl/certs/h2o.crt' do
	source 'examples/h2o/server.crt'
end

cookbook_file '/etc/ssl/private/h2o.key' do
	source 'examples/h2o/server.key'
end

cookbook_file '/etc/ssl/certs/h2o_alternate.crt' do
	source 'examples/h2o/alternate.crt'
end
cookbook_file '/etc/ssl/private/h2o_alternate.key' do
	source 'examples/h2o/alternate.key'
end

execute 'update-rc.d h2o defaults'

service 'h2o' do
	action [:start, :enable]
end