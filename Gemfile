# source 'https://rubygems.org'
source 'https://rails-assets.org'
source 'http://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.15'

#https://bitbucket.org/ged/ruby-pg/wiki/Home
# gem 'pg', '~> 0.17.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.4.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'less-rails', '~> 2.4.2'

#gem 'compass-rails'#, '~> 2.0.alpha.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.0.4'

gem 'jquery-ui-rails', '~> 4.1.1'

# gem 'rails-assets-jquery-file-upload'
# gem 'rails-assets-jcrop'
gem 'rails-assets-keymaster'

# gem 'blueimp-load-image-rails', '~> 1.9.1'

# gem 'semantic-ui-rails', '~> 0.10.3'
gem 'semantic-ui-sass', '~> 0.12.0.0'  #https://github.com/doabit/semantic-ui-sass

# https://github.com/xing/wysihtml5
# https://github.com/narkoz/wysihtml5-rails
# gem 'wysihtml5-rails', '~> 0.0.4'

# gem 'gmaps4rails', '~> 2.0.0'

# gem 'jcrop-rails', '~> 1.0.3'     #https://github.com/nragaz/jcrop-rails

# gem 'chosen-rails', '~> 1.0.0'
gem 'rails-timeago', '~> 2.8.0'

gem 'social-share-button', '~> 0.1.5'

# gem 'rails-observers', '~> 0.1.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0.1'
# gem 'rabl', '~> 0.9.3'
# gem 'crack', '~> 0.4.1'

# Redis 命名空间
gem 'redis-namespace','~> 1.4.1'

# 将一些数据存放入 Redis
gem 'redis-objects', '~> 0.8.0'

# 队列
gem 'sidekiq', '~> 2.17.3'
gem 'sinatra', '>= 1.3.0', :require => nil

# 用户系统
gem 'devise', '~> 3.2.2'
gem 'devise-async', '~> 0.9.0'
gem 'devise-i18n', '~> 0.10.2'
# gem 'omniauth', '~> 1.1.4'
# gem 'cancan', '~> 1.6.10'

gem 'by_star', :git => 'git://github.com/radar/by_star'

# 配置管理
gem 'settingslogic', '~> 2.0.9'

# 表单
gem 'simple_form', '~> 3.0.1'

# 分页
gem 'kaminari', '~> 0.15.0'

gem 'acts-as-taggable-on', '~> 2.4.1'
gem 'awesome_nested_set', '~> 2.1.6'
gem 'lazy_high_charts', '~> 1.5.1'

# Upload
gem 'mini_magick', '~> 3.7.0'
gem 'carrierwave', '~> 0.9.0'
gem 'carrierwave-qiniu', '~> 0.0.8'

# 七牛云存储
gem 'qiniu-rs'#, '~> 3.4.6'

# Image meta info
gem 'exifr', '~> 1.1.3' #https://github.com/remvee/exifr/
# gem 'xmp', '~> 0.2.0'

# PDF
# gem 'prawn', '~> 0.12.0'

# gem 'uuid', '~> 2.3.7'
gem 'nokogiri', '~> 1.6.1'
gem 'rest-client', '~> 1.6.7'

# 监测
gem 'god', '~> 0.13.3'

# Mailer
# gem 'postmark-rails'

# ChinaSMS 短信平台
# gem 'china_sms', '~> 0.0.5'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# 拼音
gem 'chinese_pinyin', '~> 0.6.1'

gem 'cells', '~> 3.8.8'

group :development, :test do
  gem 'quiet_assets', '~> 1.0.2'
  gem 'thin', '~> 1.6.1'
  gem 'better_errors', '~> 1.1.0'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'bullet', '~> 4.7.1'

  gem 'capistrano', '~> 3.1.0', require: false
  gem 'rvm-capistrano', require: false
  # gem 'rvm-capistrano', '~> 1.5.1', require: false

  gem 'rspec-rails', '~> 2.13.2'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-cells', '0.1.7'
  gem 'fuubar'
  gem 'capybara', '~> 0.4.1'
end

group :production do
  gem 'unicorn', '~> 4.8.2'
  gem 'newrelic_rpm', '~> 3.7.2.192'
  gem 'exception_notification', '~> 4.0.1'
end