# InSpec test for recipe raspi_setup::client_setup.rb

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# environment = attribute('environment', description: 'The Chef Infra environment for the node')
chef_node = input('chef_node', description: 'Chef Node')

chef_node = input('chef_node', description: 'Chef Node')
puts "\n##############################################\n\n\n 適用された Cookbook バージョン: v#{chef_node['cookbooks']}\n\n\n##############################################"

title 'タイムゾーン確認'
control 'タイムゾーン確認' do
  describe bash('timedatectl status | grep Tokyo') do
    its('stdout') { should include 'Time zone: Asia/Tokyo' }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end

control 'client.rb 設定確認' do
  describe file('/etc/chef/client.rb') do
    its('content') { should match /chef_license "accept"/ }
    its('content') { should match /chef_server_url/ }
    its('content') { should match /policy_group "raspi"/ }
    its('content') { should match /policy_name "myCloud"/ }
    its('content') { should match /log_location STDOUT/ }
    its('content') { should match /ssl_verify_mode :verify_none/ }
  end
end

control 'chef-client cron 確認' do
  describe service('cron') do
    it { should be_enabled }
    it { should be_running }
  end
  describe file('/etc/cron.d/chef-client') do
    it { should exist }
    its('mode') { should cmp '0600' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    if chef_node['platform'] == 'raspbian' # RasPi は gem 使って chef-client を実行しているため gem の場所を指定。
      its('content') { should include '/root/.rbenv/shims/chef-client' }
    else # その他のOSはデフォルトのchef-clientコマンドパスを指定。
      its('content') { should include '/opt/chef/bin/chef-client' }
    end
    its('content') { should include '0,30 * * * *' }
  end
end
