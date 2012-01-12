begin
  require "jeweler"
    Jeweler::Tasks.new do |gem|
        gem.name = "spud_cms"
        gem.summary = "Spud CMS Engine"
        gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
        gem.add_dependency 'spud_admin'
	gem.add_dependency 'paperclip'
	gem.add_dependency 'aws-s3'
	gem.add_dependency 'codemirror-rails'
	gem.authors = "David Estes"
	gem.email = "destes@redwindsw.com"
        # other fields that would normally go in your gemspec
        # like authors, email and has_rdoc can also be included here
	end
rescue
	puts "Jeweler or one of its dependencies is not installed."
end
