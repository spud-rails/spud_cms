source "http://rubygems.org"

# Declare your gem's dependencies in spud_cms.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
group :development do
	gem 'spud_core', :path => "../spud_core_admin"
end
group :test do
  gem 'mysql2'
  gem 'rspec', '2.14.0'
  gem 'shoulda', '~> 3.0.1'
  gem 'factory_girl', '~> 3.0'
  gem 'mocha', '0.14.0'
  gem "database_cleaner", "1.0.0.RC1"
  # gem 'spud_permalinks'
  gem 'rake'
end

#gem 'spud_core',:path => "../spud_core_admin"

gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

