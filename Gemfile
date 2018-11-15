source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use mysql as the database for Active Record
# gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'pg', '~> 1.1.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'spring-commands-rspec' # it speeds up rspec tests with spring-commands
end

group :development do
  gem 'thin'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # gem "capistrano", "~> 3.10", require: false
  # gem "capistrano-rails", "~> 1.3", require: false
  # gem 'capistrano3-puma', require: false
  # gem 'capistrano-rbenv', require: false
  # gem 'capistrano-secrets-yml', require: false
  # gem 'capistrano-dotenv', require: false

  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1'
end

group :production do
  gem 'puma'#, '~> 3.7'
  gem 'rails_12factor'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rack-cors'
gem 'rack-attack'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Authentication
gem 'omniauth'
gem 'devise'
gem 'devise_token_auth'
# Pagination
gem 'kaminari'
# Serialization
gem 'active_model_serializers'