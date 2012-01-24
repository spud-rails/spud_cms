# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spud_cms"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Estes"]
  s.date = "2012-01-24"
  s.email = "destes@redwindsw.com"
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "app/assets/images/spud/admin/files_thumbs/dat_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/doc_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/jpg_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/mp3_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/pdf_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/png_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/ppt_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/txt_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/xls_thumb.png",
    "app/assets/images/spud/admin/files_thumbs/zip_thumb.png",
    "app/assets/images/spud/admin/media_thumb.png",
    "app/assets/images/spud/admin/menus_thumb.png",
    "app/assets/images/spud/admin/pages_thumb.png",
    "app/assets/images/spud/admin/posts_thumb.png",
    "app/assets/images/spud/admin/templates_thumb.png",
    "app/assets/javascripts/pages.js",
    "app/assets/javascripts/spud/admin/cms/application.js",
    "app/assets/javascripts/spud/admin/templates.js",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-blockquote.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h1.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h2.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h3.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h4.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h5.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-h6.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-p.png",
    "app/assets/javascripts/wymeditor/iframe/default/lbl-pre.png",
    "app/assets/javascripts/wymeditor/iframe/default/wymiframe.css",
    "app/assets/javascripts/wymeditor/iframe/default/wymiframe.html",
    "app/assets/javascripts/wymeditor/jquery.wymeditor.pack.js",
    "app/assets/javascripts/wymeditor/lang/bg.js",
    "app/assets/javascripts/wymeditor/lang/ca.js",
    "app/assets/javascripts/wymeditor/lang/cs.js",
    "app/assets/javascripts/wymeditor/lang/cy.js",
    "app/assets/javascripts/wymeditor/lang/de.js",
    "app/assets/javascripts/wymeditor/lang/en.js",
    "app/assets/javascripts/wymeditor/lang/es.js",
    "app/assets/javascripts/wymeditor/lang/fa.js",
    "app/assets/javascripts/wymeditor/lang/fi.js",
    "app/assets/javascripts/wymeditor/lang/fr.js",
    "app/assets/javascripts/wymeditor/lang/gl.js",
    "app/assets/javascripts/wymeditor/lang/he.js",
    "app/assets/javascripts/wymeditor/lang/hr.js",
    "app/assets/javascripts/wymeditor/lang/hu.js",
    "app/assets/javascripts/wymeditor/lang/it.js",
    "app/assets/javascripts/wymeditor/lang/nb.js",
    "app/assets/javascripts/wymeditor/lang/nl.js",
    "app/assets/javascripts/wymeditor/lang/nn.js",
    "app/assets/javascripts/wymeditor/lang/pl.js",
    "app/assets/javascripts/wymeditor/lang/pt-br.js",
    "app/assets/javascripts/wymeditor/lang/pt.js",
    "app/assets/javascripts/wymeditor/lang/ru.js",
    "app/assets/javascripts/wymeditor/lang/sv.js",
    "app/assets/javascripts/wymeditor/lang/tr.js",
    "app/assets/javascripts/wymeditor/lang/zh_cn.js",
    "app/assets/javascripts/wymeditor/plugins/embed/jquery.wymeditor.embed.js",
    "app/assets/javascripts/wymeditor/plugins/fullscreen/icon_fullscreen.gif",
    "app/assets/javascripts/wymeditor/plugins/fullscreen/jquery.wymeditor.fullscreen.js",
    "app/assets/javascripts/wymeditor/plugins/hovertools/jquery.wymeditor.hovertools.js",
    "app/assets/javascripts/wymeditor/plugins/resizable/jquery.wymeditor.resizable.js",
    "app/assets/javascripts/wymeditor/plugins/resizable/readme.txt",
    "app/assets/javascripts/wymeditor/plugins/tidy/README",
    "app/assets/javascripts/wymeditor/plugins/tidy/jquery.wymeditor.tidy.js",
    "app/assets/javascripts/wymeditor/plugins/tidy/tidy.php",
    "app/assets/javascripts/wymeditor/plugins/tidy/wand.png",
    "app/assets/javascripts/wymeditor/skins/compact/icons.png",
    "app/assets/javascripts/wymeditor/skins/compact/skin.css",
    "app/assets/javascripts/wymeditor/skins/compact/skin.js",
    "app/assets/javascripts/wymeditor/skins/default/icons.png",
    "app/assets/javascripts/wymeditor/skins/default/skin.css",
    "app/assets/javascripts/wymeditor/skins/default/skin.js",
    "app/assets/javascripts/wymeditor/skins/minimal/images/bg.header.gif",
    "app/assets/javascripts/wymeditor/skins/minimal/images/bg.selector.silver.gif",
    "app/assets/javascripts/wymeditor/skins/minimal/images/bg.wymeditor.png",
    "app/assets/javascripts/wymeditor/skins/minimal/images/icons.silver.gif",
    "app/assets/javascripts/wymeditor/skins/minimal/skin.css",
    "app/assets/javascripts/wymeditor/skins/minimal/skin.js",
    "app/assets/javascripts/wymeditor/skins/silver/COPYING",
    "app/assets/javascripts/wymeditor/skins/silver/README",
    "app/assets/javascripts/wymeditor/skins/silver/images/bg.header.gif",
    "app/assets/javascripts/wymeditor/skins/silver/images/bg.selector.silver.gif",
    "app/assets/javascripts/wymeditor/skins/silver/images/bg.wymeditor.png",
    "app/assets/javascripts/wymeditor/skins/silver/images/icons.silver.gif",
    "app/assets/javascripts/wymeditor/skins/silver/skin.css",
    "app/assets/javascripts/wymeditor/skins/silver/skin.js",
    "app/assets/javascripts/wymeditor/skins/twopanels/icons.png",
    "app/assets/javascripts/wymeditor/skins/twopanels/skin.css",
    "app/assets/javascripts/wymeditor/skins/twopanels/skin.js",
    "app/assets/javascripts/wymeditor/skins/wymeditor_icon.png",
    "app/assets/stylesheets/pages.css",
    "app/assets/stylesheets/spud/admin/cms/application.css",
    "app/controllers/pages_controller.rb",
    "app/controllers/spud/admin/media_controller.rb",
    "app/controllers/spud/admin/menu_items_controller.rb",
    "app/controllers/spud/admin/menus_controller.rb",
    "app/controllers/spud/admin/pages_controller.rb",
    "app/controllers/spud/admin/posts_controller.rb",
    "app/controllers/spud/admin/templates_controller.rb",
    "app/helpers/pages_helper.rb",
    "app/helpers/spud/admin/contacts_helper.rb",
    "app/helpers/spud/admin/media_helper.rb",
    "app/helpers/spud/admin/menu_items_helper.rb",
    "app/helpers/spud/admin/menus_helper.rb",
    "app/helpers/spud/admin/pages_helper.rb",
    "app/helpers/spud/admin/posts_helper.rb",
    "app/helpers/spud/admin/templates_helper.rb",
    "app/helpers/spud/admin/users_helper.rb",
    "app/helpers/spud/cms/application_helper.rb",
    "app/helpers/spud/user_sessions_helper.rb",
    "app/models/spud_category.rb",
    "app/models/spud_custom_field.rb",
    "app/models/spud_media.rb",
    "app/models/spud_menu.rb",
    "app/models/spud_menu_item.rb",
    "app/models/spud_page.rb",
    "app/models/spud_page_partial.rb",
    "app/models/spud_post.rb",
    "app/models/spud_post_category.rb",
    "app/models/spud_template.rb",
    "app/views/layouts/spud/admin/cms/detail.html.erb",
    "app/views/pages/show.html.erb",
    "app/views/spud/admin/contacts/index.html.erb",
    "app/views/spud/admin/media/index.html.erb",
    "app/views/spud/admin/media/new.html.erb",
    "app/views/spud/admin/menu_items/_form.html.erb",
    "app/views/spud/admin/menu_items/_menu_item_row.html.erb",
    "app/views/spud/admin/menu_items/edit.html.erb",
    "app/views/spud/admin/menu_items/index.html.erb",
    "app/views/spud/admin/menu_items/new.html.erb",
    "app/views/spud/admin/menus/_form.html.erb",
    "app/views/spud/admin/menus/edit.html.erb",
    "app/views/spud/admin/menus/index.html.erb",
    "app/views/spud/admin/menus/new.html.erb",
    "app/views/spud/admin/pages/_form.html.erb",
    "app/views/spud/admin/pages/_page_partials_form.html.erb",
    "app/views/spud/admin/pages/_page_row.html.erb",
    "app/views/spud/admin/pages/edit.html.erb",
    "app/views/spud/admin/pages/index.html.erb",
    "app/views/spud/admin/pages/new.html.erb",
    "app/views/spud/admin/pages/show.html.erb",
    "app/views/spud/admin/templates/_form.html.erb",
    "app/views/spud/admin/templates/edit.html.erb",
    "app/views/spud/admin/templates/index.html.erb",
    "app/views/spud/admin/templates/new.html.erb",
    "config/application.rb",
    "config/boot.rb",
    "config/routes.rb",
    "lib/spud_cms.rb",
    "lib/spud_cms/configuration.rb",
    "lib/spud_cms/engine.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Spud CMS Engine"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spud_admin>, [">= 0"])
      s.add_runtime_dependency(%q<paperclip>, [">= 0"])
      s.add_runtime_dependency(%q<codemirror-rails>, [">= 0"])
    else
      s.add_dependency(%q<spud_admin>, [">= 0"])
      s.add_dependency(%q<paperclip>, [">= 0"])
      s.add_dependency(%q<codemirror-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<spud_admin>, [">= 0"])
    s.add_dependency(%q<paperclip>, [">= 0"])
    s.add_dependency(%q<codemirror-rails>, [">= 0"])
  end
end

