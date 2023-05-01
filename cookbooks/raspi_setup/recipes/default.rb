#
# Cookbook:: raspi_setup
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

#
# Cookbook:: raspi_setup
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

timezone "Set TZ to #{node['raspi_setup']['timezone']}" do
  timezone "#{node['raspi_setup']['timezone']}"
end

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['raspi_setup']['chef_server']['fqdn']}/organizations/#{node['raspi_setup']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  policy_name "#{node['raspi_setup']['policy_name']}"
  policy_group "#{node['raspi_setup']['policy_group']}"
  ssl_verify_mode :verify_none
end

###########
# Control chef-client version with `chef_client_updater` cookbook 'https://github.com/chef-cookbooks/chef_client_updater'
###########

chef_client_updater "up or down grade Chef Infra version to #{node['raspi_setup']['client_updater']['version']}" do
  version "#{node['raspi_setup']['client_updater']['version']}"
  channel "#{node['raspi_setup']['client_updater']['channel']}"
  post_install_action 'exec'
end

###########
# Set up a cron job for chef-client to run every 30 mins
###########
chef_client_cron 'Run Chef Infra Client as a cron job' do
  accept_chef_license true
  minute "#{node['chef_client_cron']['minute']}"
  splay "#{node['chef_client_cron']['splay']}"
  chef_binary_path '/root/.rbenv/shims/chef-client' if platform?('raspbian') # RasPi は gem 使って chef-client を実行しているため gem の場所を指定する。
end
