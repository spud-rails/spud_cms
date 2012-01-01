module SpudCms
   require 'spud_cms/engine' if defined?(Rails)
   SpudAdmin::Engine.add_admin_application({:name => "Pages",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/pages",:order => 0})
   SpudAdmin::Engine.add_admin_application({:name => "Posts",:thumbnail => "spud/admin/posts_thumb.png",:url => "/spud/admin/posts",:order => 1})
   SpudAdmin::Engine.add_admin_application({:name => "Media",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/media",:order => 2})
   SpudAdmin::Engine.add_admin_application({:name => "Templates",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/templates",:order => 3})
   SpudAdmin::Engine.add_admin_application({:name => "Contacts",:thumbnail => "spud/admin/contacts_thumb.png",:url => "/spud/admin/contacts",:order => 99})
end
