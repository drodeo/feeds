source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'annotate'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  #gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'mailcatcher'
  gem 'rspec-rails'

  # gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'guard-rspec', '~> 4.6', '>= 4.6.4'
  gem 'selenium-webdriver', '~> 2.53'
  gem 'capybara', '~> 2.6', '>= 2.6.2'
  # gem 'libnotify', '~> 0.9.1'
  gem 'faker'
  gem 'shoulda'
 # gem 'cucumber-rails', require: false
  gem 'pry'
  #gem 'database_cleaner'
  gem 'launchy'
  gem 'rails_best_practices', require: false
  #gem 'rb-inotify', github: 'kvokka/rb-inotify', require: false
  gem 'rubocop', require: false
  #gem 'rubycritic', require: false
  gem 'traceroute'
end

group :test do
  #gem "fuubar"
  # gem "capybara-webkit"
  gem "database_cleaner"
  #gem "formulaic"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'
gem 'pg'

gem 'paperclip'

#gem 'will_paginate'
gem 'kaminari'
gem 'simple_form'
gem 'redcarpet'
gem 'rails_admin'
gem 'yaml_db'
gem 'friendly_id'
gem 'babosa'
gem 'nokogiri'
gem 'acts_as_tree'
gem 'text'
gem 'feedjira'
gem 'acts-as-taggable-on'
gem 'whenever', require: false
#gem 'rack-mini-profiler'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'ransack'
gem 'haml-rails'
gem 'truncate_html'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'sidekiq-status'
gem 'sidekiq-cron'
gem 'sidekiq-statistic'
gem 'sidekiq-status'
gem 'telegram_bot'
gem 'telegram-bot-ruby'
gem "ruby-stemmer"
gem "tf-idf-similarity"
gem 'twitter', github: 'sferik/twitter'
gem 'figaro'
gem 'ruby-prof'

