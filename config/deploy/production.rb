server '13.113.31.248', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/okadatomohiro/.ssh/id_rsa.pub'
