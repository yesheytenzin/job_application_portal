source "https://rubygems.org"
gem "rails", "~> 8.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
# gem "jbuilder"
# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "faker"
  gem "factory_bot_rails"
  gem "pry"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-faker", require: false
  gem "rubocop-rake", require: false
  gem "brakeman", require: false
end

group :test do
  gem "rspec-rails"
  gem "simplecov", require: false
end
