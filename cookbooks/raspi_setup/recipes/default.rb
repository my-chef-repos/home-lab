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

# include_profile 'raspi_setup::validation_tests'

timezone "Set TZ to #{node['raspi_setup']['timezone']}" do
  timezone "#{node['raspi_setup']['timezone']}"
end

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['raspi_setup']['chef_server']['fqdn']}/organizations/#{node['raspi_setup']['org_name']}"
  chef_license 'accept'
  policy_name "#{node['raspi_setup']['policy_name']}"
  policy_group "#{node['raspi_setup']['policy_group']}"
  ssl_verify_mode :verify_none
  additional_config <<~CONFIG
  validation_client_name  'home-lab-validator'
  validation_key          '/etc/chef/home-lab-validator.pem'
  CONFIG
end

###########
# Set up a cron job for chef-client to run every 30 mins
###########
chef_client_cron 'Run Chef Infra Client as a cron job' do
  accept_chef_license true
  minute 0
  hour "#{node['chef_client_cron']['hour']}"
  chef_binary_path '/root/.rbenv/shims/chef-client' if platform?('raspbian') # RasPi は gem 使って chef-client を実行しているため gem の場所を指定する。
end
