# Encoding: utf-8
require 'spec_helper'

describe 'kiwiirc::install' do
  let(:user) { 'kiwiirc' }
  let(:group) { 'kiwiirc' }

  describe group('kiwiirc') do
    it { should exist }
  end

  describe user('kiwiirc') do
    it { should exist }
    it { should belong_to_group group }
    it { should have_home_directory '/home/kiwiirc' }
    it { should have_login_shell '/bin/false' }
  end

  describe file('/home/kiwiirc') do
    it { should be_directory }
    it { should be_owned_by user }
    it { should be_grouped_into group }
    it { should be_mode 750 }
  end

  %w(client server server_modules tmp node_modules .git .npm).each do |dir|
    describe file("/home/kiwiirc/#{dir}") do
      it { should be_directory }
      it { should be_owned_by user }
      it { should be_grouped_into group }
      it { should be_mode 755 }
    end
  end

  %w(kiwi kiwi.bat).each do |f|
    describe file("/home/kiwiirc/#{f}") do
      it { should be_file }
      it { should be_owned_by user }
      it { should be_grouped_into group }
      it { should be_mode 755 }
    end
  end

  %w(config.example.js package.json
     client/build.js client/index.html
     client/assets/kiwi.js client/assets/kiwi.min.js
     server/server.js).each do |f|
    describe file("/home/kiwiirc/#{f}") do
      it { should be_file }
      it { should be_owned_by user }
      it { should be_grouped_into group }
      it { should be_mode 644 }
    end
  end

end
