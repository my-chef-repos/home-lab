###
# These attributes are to be adjusted in the policy group accordingly.
###

# Specify node Time Zone
default['raspi_setup']['timezone'] = 'Asia/Tokyo'

# Specify Chef Server FQDN & IP
default['raspi_setup']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name and its key file name
default['raspi_setup']['org_name'] = 'home-lab'
default['raspi_setup']['org_validator_name'] = 'home-lab-validator.pem'

# Specify Policy name & Policy group OR Environment
default['raspi_setup']['policy_name'] = 'myCloud'
default['raspi_setup']['policy_group'] = 'raspi'

# Specify chef-client version
default['raspi_setup']['client_updater']['version'] = '17.10.0'
default['raspi_setup']['client_updater']['channel'] = 'stable'

# Specify chef-client cron interval settings
default['chef_client_cron']['minute'] = '0,30'
default['chef_client_cron']['splay'] = 300

# Invoke the Compliance Phase
default['audit']['compliance_phase'] = true
