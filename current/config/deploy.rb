set :application, "mrcc"
#set :repository,  "git@github.com:overdrivedesign/MuskokaRoastery.git"
set :repository,  "git@github.com:robmclarty/muskoka.git"
set :deploy_to, "/var/www/vhosts/muskokaroastery.com/rails"

set :scm, :git # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, "master"

set :user, "root"
set :group, "root"
set :deployed_user, "root"
set :deployed_group, "root"
set :use_sudo, false
set :_MT_ENV, "PATH=/usr/local/bin:$PATH RUBYLIB=/usr/local/lib/ruby GEM_HOME=/root/.gem/ruby/1.9.1:/usr/local/lib/ruby/gems/1.9.1"

set :copy_exclude, [".git", "spec", "test", "public/system"]

set :deploy_via, :copy
set :ssh_options, { :forward_agent => true }
set :keep_releases, 5

default_run_options[:pty] = true

role :web, "root@72.10.37.197"                   # Your HTTP server, Apache/etc
role :app, "root@72.10.37.197"                   # This may be the same as your `Web` server
role :db,  "root@72.10.37.197", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Update bundled gems"
  task :bundle_install, :roles => [:app, :db, :web] do
    run "cd #{current_path}; #{try_sudo} bundle install --without development:test"
  end

  desc "Fix file permissions"
  task :fix_file_permissions, :roles => [:app, :db, :web] do
    run "#{try_sudo} chmod -R g+rw #{deploy_to}/releases"
    run "#{try_sudo} chown -R apache:nobody #{deploy_to}/releases"
    run "#{try_sudo} chmod -R g+rw #{deploy_to}/current"
    run "#{try_sudo} chown -R apache:nobody #{deploy_to}/current"
  end

  desc "Compile assets"
  task :assets, :roles => [:app, :db, :web] do
    run "cd #{current_path}; #{try_sudo} RAILS_ENV=production bundle exec rake assets:precompile"
  end

  # desc "Update assets with jammit --force"
  # task :jammit, :roles => [:app, :db, :web] do
  #   run "cd #{current_path}; #{try_sudo} jammit --force"
  # end

  # desc "Update crontab with Whenever tasks"
  # task :update_crontab, :roles => [:app, :db, :web] do
  #   run "cd #{deploy_to}/current && whenever --update-crontab #{application}"
  # end
end

after "deploy:symlink", "deploy:fix_file_permissions"
#after "deploy:symlink", "deploy:bundle_install"
#after "deploy:symlink", "deploy:assets"
#after "deploy:symlink", "deploy:update_crontab"
