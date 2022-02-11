# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'rails-i18n'
gem 'rollbar'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

gem 'acts-as-taggable-on', '~> 6.0'
gem 'cancancan'
gem 'passenger'
gem 'geocoder'
gem 'carrierwave', '~> 2.0'
gem 'devise'
gem 'jb'
gem 'kaminari'
gem 'paranoia', '~> 2.4', '>= 2.4.2'
gem 'pg', '~> 0.18.4'
gem 'semver'
gem 'sidekiq', '~> 5.2', '>= 5.2.7'
gem 'unicorn'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

# FRONT END GEMS
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap-select-rails'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'flag-icons-rails'
gem 'font_awesome5_rails'
gem 'jquery-slick-rails'
gem 'lazysizes_rails'
gem 'momentjs-rails'
gem 'rails_sortable'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'select2-rails'
gem 'simple_calendar', '~> 2.0'
gem 'tinymce-rails'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-validation-rails'
gem 'slim-rails'
gem 'sprockets'
gem 'uglifier'

gem 'dotenv-rails'
gem 'exception_notification'
gem 'sidekiq-failures'
gem 'sidekiq_alive'

gem 'ahoy_email'
gem 'ahoy_matey'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'maxminddb'
gem 'paper_trail'
gem 'ruby-oembed'
gem 'webp-ffi'

gem 'capistrano', '~> 3.11'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

group :development, :test do
  gem 'annotate', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.0.beta3'
end

group :development do
  gem 'bullet'
  gem 'meta_request'
  # gem 'rack-mini-profiler'

  gem 'capistrano-sidekiq'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  gem 'rubocop', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
