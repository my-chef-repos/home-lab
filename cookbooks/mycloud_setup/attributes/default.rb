###
# These attributes are to be adjusted in the policy group accordingly.
###

# Specify node Time Zone
default['mycloud_setup']['timezone'] = 'Asia/Tokyo'

# Specify Chef Server FQDN & IP
default['mycloud_setup']['chef_server']['fqdn'] = 'automate.cl'

# Specify Org name and its key file name
default['mycloud_setup']['org_name'] = 'home-lab'
default['mycloud_setup']['org_validator_name'] = 'home-lab-validator.pem'

# Specify Policy name & Policy group OR Environment
default['mycloud_setup']['policy_name'] = 'myCloud'
default['mycloud_setup']['policy_group'] = 'raspi'

# Specify chef-client cron interval settings
default['chef_client_cron']['hour'] = '0,12'
