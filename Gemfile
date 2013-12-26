source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.0.0'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'farm_tools', :git => 'https://github.com/jessethebuilder/farm_tools'
gem 'twitter_express', :git => 'https://github.com/jessethebuilder/TwitterExpress'
#gem 'twitter_express', :path => 'C:\Users\jf\Desktop\jesseweb\TwitterExpress'


gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :github => 'anjlab/bootstrap-rails'

gem 'devise'
gem 'geocoder'

group :test, :development do
  gem 'faker'
  gem 'rspec-rails'
  gem 'wdm'
  gem 'database_cleaner', '~> 1.0.0rc'
  gem 'timecop'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'launchy', '~> 2.3.0'
  #gem 'webrat'
end

group :production do
  gem 'rails_12factor'
  gem 'faker'
end

ruby '2.0.0'