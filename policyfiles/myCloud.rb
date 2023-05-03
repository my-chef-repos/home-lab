# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'myCloud'

# Where to find external cookbooks:
default_source :chef_server, 'https://automate/organizations/home-lab'

# run_list: chef-client will run these recipes in the order specified.
run_list 'raspi_setup::default'
cookbook 'raspi_setup', '2.0.0'

# Attributes
default['chef_client_cron']['hour'] = '0,12'

# Compliance/Security Scan
override['audit']['compliance_phase'] = true
default['audit']['fetcher'] = 'chef-server'
default['audit']['reporter'] = 'chef-server-automate'

default['audit']['profiles']['cis-level-1'] = {
  'git': 'https://github.com/my-chef-repos/cis-debian9-level-1.git',
}

# default['audit']['profiles']['linux-baseline'] = {
#   'git': 'https://github.com/dev-sec/linux-baseline.git',
# }

# default['audit']['profiles']['ssh-baseline'] = {
#   'git': 'https://github.com/dev-sec/ssh-baseline.git',
# }

# default['audit']['profiles']['cis-level-2'] = {
#   'git': 'https://github.com/my-chef-repos/cis-debian9-level-2.git',
# }
