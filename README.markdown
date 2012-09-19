Spud CMS
========

Spud CMS is a CMS Engine designed to be robust, easy to use, and light weight.


Installation/Usage
------------------

1. In your Gemfile add the following

		gem 'spud_cms'

2. Run bundle install
3. Copy in database migrations to your new rails project

		bundle exec rake railties:install:migrations
		rake db:migrate
4. Change ApplicationController to inherit from Spud::ApplicationController instead of ActionController::Base

		class ApplicationController < Spud::ApplicationController

5. run a rails server instance and point your browser to /spud/admin

Routing to the CMS Engine
--------------------------
Routing your home page to the CMS engine is fairly straight forward.
in your applications environment.rb file add a configure block as such


		Spud::Cms.configure do |config|
			config.menus_enabled = true
			config.templates_enabled = false
			config.root_page_name = "home"
		end



Where "home" is the page name you wish to use.

Pages will default render to the 'application' layout of your application. You can change this by using templates to specify base layouts.

Using Menus
-----------
A lot of cms engines allow you to render your navigation links in a ul block by using your page tree structure. In a lot of cases this is insufficient as some sites have urls that redirect to pages outside of your cms. This is where menus come in. They can be built in the spud admin control panel.
In your application layout file or any erb template you can render a ul block like so

		<%=sp_list_menu({:id => "navigation",:name => "Main"})%>

This will output a <ul id="navigation"></ul> block for the menu you created in admin named "Main"


Adding Your Own Engines
-----------------------

Creating a rails engine that ties into spud admin is fairly straight forward
In your new engine add spud_admin as a dependency and create an initializer inside your engine class as such:

		initializer :admin do
			Spud::Core.configure do |config|
			config.admin_applications += [{:name => "Pages",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/pages",:order => 0}]

			end
		end

You can use the layouts provided with spud admin by using 'spud/admin/application' or 'spud/admin/detail' layouts

When creating controllers for the admin panel create them in the Spud::Admin Namespace and have them extend Spud::Admin::ApplicationController for automatic user authentication restrictions.

Testing
-----------------

Spud uses RSpec for testing. Get the tests running with a few short commands:

1. Create and migrate the databases:

        rake db:create
        rake db:migrate

2. Load the schema in to the test database:

        rake app:db:test:prepare

3. Run the tests with RSpec

        rspec spec

After the tests have completed the current code coverage stats is available by opening ```/coverage/index.html``` in a browser.



