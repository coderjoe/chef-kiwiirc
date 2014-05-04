# Encoding: utf-8
include_recipe 'nodejs'
include_recipe 'nodejs::npm'

package 'git'

kiwi_user = node[:kiwiirc][:user]
kiwi_group = node[:kiwiirc][:group]
kiwi_directory = node[:kiwiirc][:directory]
kiwi_repo = node[:kiwiirc][:git][:uri]
kiwi_revision = node[:kiwiirc][:git][:revision]

group kiwi_group do
  system true
end

user kiwi_user do
  home kiwi_directory
  gid kiwi_group
  shell '/bin/false'
  system true
  action :create
end

directory kiwi_directory do
  owner kiwi_user
  group kiwi_group
  mode 0750
  recursive true
  action :create
end

git kiwi_directory do
  repository kiwi_repo
  revision kiwi_revision
  action :sync
  user kiwi_user
  group kiwi_group
end

bash 'npm install' do
  environment('HOME' => kiwi_directory)
  cwd kiwi_directory
  code 'npm install'
  user kiwi_user
  group kiwi_group
  action :run
end

bash 'build web files' do
  cwd kiwi_directory
  code './kiwi build'
  user kiwi_user
  group kiwi_group
  action :run
end
