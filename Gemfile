source "http://rubygems.org"

# Declare your gem's dependencies in spud_cms.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
group :development, :test do
  gem 'mysql2', '0.3.11'
  gem 'rspec-rails', '2.8.1'
  gem 'spud_permalinks'
end
group :test do
  gem 'rspec', '2.8.0'
  gem 'shoulda', :git => 'git://github.com/3den/shoulda.git' # gem 'shoulda', '2.11.3' # gem needs updated for rails 3.2 from pending pull requests.
  gem 'factory_girl', '2.5.0'
  gem 'mocha', '0.10.3'
  gem "database_cleaner", "0.7.1"
end
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
