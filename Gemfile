source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'faraday'
gem 'font-awesome-rails'
gem 'geocoder'
gem 'jbuilder', '~> 2.7'
gem 'pagy'
gem 'paper_trail'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.4'
gem 'react_on_rails'
gem 'sass-rails', '>= 6'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'simple_form'
gem 'slim-rails'
gem 'stripe'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'stripe-ruby-mock', '~> 3.1.0.rc2', require: 'stripe_mock'
  gem 'webmock'
end

group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'any_login'
  gem 'bullet'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

gem 'mini_racer', platforms: :ruby
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
