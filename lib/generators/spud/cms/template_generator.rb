require 'rails/generators/migration'

class Spud::Cms::TemplateGenerator < ::Rails::Generators::Base
  desc "This generator creates a new spud cms layout file"
  argument :template_name, :type => :string
  argument :attributes, :type => :array, :default => [], :banner => "content_block content_block"

  source_root File.expand_path('../templates', __FILE__)

  def create_module
    template "template.html.erb", "app/views/layouts/#{template_name.downcase.underscore}.html.erb"
  end

private


end
