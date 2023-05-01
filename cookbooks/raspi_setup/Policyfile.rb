# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'raspi_setup'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'raspi_setup::default'

# Specify a custom source for a single cookbook:
cookbook 'raspi_setup', path: '.'
cookbook 'chef_client_updater', '~> 3.12.3', :supermarket

