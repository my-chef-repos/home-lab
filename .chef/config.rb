current_dir = File.dirname(__FILE__)
  user = 'r-goto'
  node_name                user
  chef_server_url          'https://automate.cl/organizations/home-lab'
  cookbook_path            ["#{current_dir}/../cookbooks"]
  cookbook_copyright       "First Org Cookbooks"
  cookbook_license         "Apache-2.0"
  cookbook_email           "cookbooks@aws.org"
  chef_license             'accept'
  ssl_verify_mode          :verify_none
  client_key               "#{current_dir}/client.pem"