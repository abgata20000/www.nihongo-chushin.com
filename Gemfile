# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'active_decorator'
gem 'active_decorator_with_decorate_associations'
gem 'active_hash'
gem 'active_type'
gem 'baby_squeel'
gem 'bugsnag'
gem 'default_value_for'
gem 'dotenv-rails'
gem 'enumerize', github: 'brainspec/enumerize'
gem 'kaminari'
gem 'rack-user_agent'
gem 'ransack'
gem 'ridgepole'
gem 'scaffoldable', github: 'radicodeinc/scaffoldable', branch: 'rails_5_2_1#11'
gem 'simple_form'
gem 'slim-rails'
# sidekiq
# gem 'sidekiq'
# gem 'sidekiq-failures'
# gem 'sidekiq-history'
# gem 'sidekiq-statistic'
# gem 'sidekiq-limit_fetch'
#
gem 'newrelic_rpm'
gem 'redis-namespace'
gem 'redis-rails'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'

group :test, :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'database_rewinder'
  gem 'delorean'
  gem 'factory_bot_rails'
  gem 'faker', '~> 1.4.3'
  gem 'fakeweb'
  gem 'launchy', '~> 2.4.2'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-json_matcher'
  gem 'rspec-rails'
  gem 'rspec-retry'
  gem 'rspec_junit_formatter', '0.2.2' # for circleci
  gem 'rubocop'
  gem 'selenium-webdriver'
end

group :development, :staging, :staging_heroku do
  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate', git: 'git://github.com/ctran/annotate_models.git'
  gem 'pry'
  gem 'pry-rails'
  gem 'rails_layout', github: 'RailsApps/rails_layout'
  gem 'seed_dump'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'view_source_map'
end

group :test do
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
