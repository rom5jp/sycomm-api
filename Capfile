require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/dotenv'
require 'capistrano/puma'
require 'capistrano/rails/migrations'
 
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Workers
install_plugin Capistrano::Puma::Nginx

invoke 'dotenv:read'
invoke 'dotenv:check'
invoke 'dotenv:setup'
 
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
