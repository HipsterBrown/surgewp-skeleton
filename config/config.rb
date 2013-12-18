# SurgeWP Capistrano Configuration file

set :application, "Appication title"

# Make sure to use a read only github URL, i.e git://github.com/connorblack/test-site.git

set :repository,  "Set your git repository location here"
set :scm, :git

# Set Git Submodules
set :git_enable_submodules, 1

# This should be the same as :deploy_to in production.rb
set :production_deploy_to, '/www/example.com'

# The domain name used for your staging environment
set :staging_domain, 'staging.example.com'

# Set your server username
set :user, "username"
set :use_sudo, true

# Tells capistrano to create a pty for each process
default_run_options[:pty] = true

# Database
# Set the values for host, user, pass, and name for both production and staging.
set :wpdb do
	{
		:production => {
			:host     => 'PRODUCTION DB HOST',
			:user     => 'PRODUCTION DB USER',
			:password => 'PRODUCTION DB PASS',
			:name     => 'PRODUCTION DB NAME',
		},
		:staging => {
			:host     => 'STAGING DB HOST',
			:user     => 'STAGING DB USER',
			:password => 'STAGING DB PASS',
			:name     => 'STAGING DB NAME',
		}
	}
end

# You're not done! You must also configure production.rb and staging.rb