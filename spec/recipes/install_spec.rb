# Encoding: utf-8
require 'spec_helper'

describe 'kiwiirc::install' do
  let(:user) { 'kiwiusername' }
  let(:group) { 'kiwigroup' }
  let(:install_dir) { '/home/dirname' }
  let(:repo_uri) { 'https://examplegithub.com/fake/uri.git' }
  let(:repo_revision) { 'v1.2.3' }
  let(:chef_run) do
    stub_command("/usr/local/bin/npm -v 2>&1 | grep '1.3.5'").and_return('')
    ChefSpec::Runner.new do |node|
      node.set[:kiwiirc][:user] = user
      node.set[:kiwiirc][:group] = group
      node.set[:kiwiirc][:directory] = install_dir
      node.set[:kiwiirc][:git][:uri] = repo_uri
      node.set[:kiwiirc][:git][:revision] = repo_revision
    end.converge(described_recipe)
  end

  it 'should add a kiwiirc group' do
    expect(chef_run).to create_group(group).with(system: true)
  end

  it 'should add a kiwiirc user' do
    expect(chef_run).to create_user(user).with(
      gid: group,
      home: install_dir,
      shell: '/bin/false',
      system: true
    )
  end

  it 'should create the install directory' do
    expect(chef_run).to create_directory(install_dir).with(
      owner: user,
      group: group,
      recursive: true,
      mode: 0750
    )
  end

  it 'should install nodejs' do
    expect(chef_run).to include_recipe 'nodejs'
  end

  it 'should install npm' do
    expect(chef_run).to include_recipe 'nodejs::npm'
  end

  it 'should install git' do
    expect(chef_run).to install_package 'git'
  end

  it 'clone the kiwiirc repo' do
    expect(chef_run).to sync_git(install_dir).with(
      repository: repo_uri,
      revision: repo_revision,
      user: user,
      group: group
    )
  end

  it 'should install the npm libraries' do
    expect(chef_run).to run_bash('npm install').with(
      cwd: install_dir,
      code: 'npm install',
      environment: { 'HOME' => install_dir },
      user: user,
      group: group
    )
  end

  it 'should build the html files' do
    expect(chef_run).to run_bash('build web files').with(
      cwd: install_dir,
      code: './kiwi build',
      user: user,
      group: group
    )
  end
end
