set :application, "set your application name here"
set :repository,  "set your repository location here"
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# set :scm, :git
# set :git_shallow_clone, 1
# set :git_enable_submodules, 1
# set :deploy_via, :remote_cache
# set :branch, 'master'
# set :repository_cache, "#{application}-src"
# set :key_relesaes, 3
# set :use_sudo, false
# set :ssh_options, :forward_agent => true

role :app, "your app-server here"
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true

namespace :deploy do
  desc "restart passenger app"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end