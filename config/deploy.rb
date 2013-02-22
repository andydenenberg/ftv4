require "bundler/capistrano"
require "rvm/capistrano"

set :application, "Ftv4"
set :repository,  "git@github.com:andydenenberg/ftv4.git"
set :deploy_to, "/var/www/ftv4"
set :user, "ubuntu"
set :keep_releases, 5
set :normalize_asset_timestamps, false  # 

role :web, "107.20.214.190"  # Your HTTP server, Apache/etc
role :app, "107.20.214.190"  # This may be the same as your `Web` server
role :db,  "107.20.214.190", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

after "deploy", "deploy:symlink_db", "deploy:precompile_assets"

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
  end

  desc "Precompile Assets"
  task :precompile_assets, :roles => :app do
# run "/bin/bash -l -c 'cd #{release_path} && RAILS_ENV=production rake assets:precompile'"
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  end
end

desc "tail production log files" 
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end

# if you want to clean up old releases on each deploy uncomment this:
 after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end