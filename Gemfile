source 'https://rubygems.org/'

ruby '>= 2.6.6', '< 2.7.0'
gem 'rails', '4.2.10'

# for Heroku deployment
group :development, :test do
  gem 'pg', '~> 0.20'
  gem 'byebug'
  gem 'database_cleaner', '1.4.1'
  gem 'capybara', '2.4.4'
  gem 'launchy'
  gem 'rspec-rails', '3.7.2'
  gem 'ZenTest', '4.11.2'
  gem 'bcrypt', '~> 3.1.7'
end

group :test do
  gem 'pg', '~> 0.20'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end
group :production do
  gem 'pg', '~> 0.20'
  gem 'rails_12factor'
  gem 'bcrypt', '~> 3.1.7'
end

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.7.1'
gem 'jquery-rails'