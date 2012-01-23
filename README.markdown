Spud CMS
========

Spud CMS is a CMS Engine designed to be robust, easy to use, and light weight.
NOTE: This project is still in its early infancy.

Installation/Usage
------------------

1. In your Gemfile add the following

		gem 'spud_admin', :git => "git://github.com/davydotcom/spud_core_admin.git"
		gem 'spud_cms', :git => "git://github.com/davydotcom/spud_cms.git"

2. Run bundle install
3. Copy in database migrations to your new rails project

		bundle exec rake spud_admin:install:migrations
		bundle exec rake spud_cms:install:migrations
		rake db:migrate

4. run a rails server instance and point your browser to /spud/admin

Routing to the CMS Engine
--------------------------
Routing your home page to the CMS engine is fairly straight forward.
in your applications routes.rb file add

```root :to => "pages#show", :id => "home"```

Where "home" is the page name you wish to use.

Pages will default render to the 'application' layout of your application. You can change this by using templates to specify base layouts.

NOTE: This project is still in its early infancy.

Adding Your Own Engines
-----------------------

Creating a rails engine that ties into spud admin is fairly straight forward
In your new engine add spud_admin as a dependency and right after your engine require line call.

	SpudAdmin::Engine.add_admin_application({
		:name => "Media",
		:thumbnail => "spud/admin/media_thumb.png",
		:url => "/spud/admin/media",
		:order => 3})

You can use the layouts provided with spud admin by using 'spud/admin/application' or 'spud/admin/detail' layouts

When creating controllers for the admin panel create them in the Spud::Admin Namespace and have them extend Spud::Admin::ApplicationController for automatic user authentication restrictions.




