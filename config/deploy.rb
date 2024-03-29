# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'unfpa'
set :repo_url, 'git@bitbucket.org:ADemiawansyah/rhknowledge.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# set :branch, 'develop'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/#{fetch :application}"

set :rollbar_token, 'eebdf0abfea84e1789937067950137bc'
set :rollbar_env, proc { fetch :stage }
set :rollbar_role, proc { :app }

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
set :sidekiq_service_name, "sidekiq"

# set :sidekiq_config, 'config/sidekiq.yml'
# set :sidekiq_processes, 2
# set :sidekiq_options_per_process, [
#   '--queue critical',
#   '--queue default --queue mailers --queue low'
# ]

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/packs', '.bundle', 'node_modules', 'public/system', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 4

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

before 'deploy:assets:precompile', 'deploy:yarn_install'

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end
end

namespace :sidekiq do
  desc "Quiet sidekiq (stop fetching new tasks from Redis)"
  task :quiet do
    on roles(:app) do
      execute :sudo, :systemctl, :kill, "-s", "TSTP", fetch(:sidekiq_service_name)
    end
  end

  desc "Restart sidekiq service"
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, fetch(:sidekiq_service_name)
    end
  end
end

after "deploy:starting", "sidekiq:quiet"
after "deploy:published", "sidekiq:restart"
