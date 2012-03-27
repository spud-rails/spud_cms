$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spud_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spud_cms"
  s.version     = Spud::Cms::VERSION
  s.authors     = ["David Estes"]
  s.email       = ["destes@redwindsw.com"]
  s.homepage    = "http://www.github.com/davydotcom/spud_cms"
  s.summary     = "Modular CMS Engine"
  s.description = "Spud CMS is a full-featured light weight modular cms engine as a part of the spud suite of rails gems. This particular gem comes with page management, administrative dashboard, template management, menu management and more. It is also capable of handling full-page caching as well as action-caching for even faster performance. Add more modules like spud_blog, spud_inquiries, spud_events, or spud_media for more features."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency 'spud_core', ">= 0.8.0","< 0.9.0"
  s.add_dependency 'spud_permalinks', "~>0.0.1"
  s.add_dependency 'codemirror-rails'

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl', '2.5.0'
  s.add_development_dependency 'mocha', '0.10.3'
  s.add_development_dependency "database_cleaner", "0.7.1"
end
