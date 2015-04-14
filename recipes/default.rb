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