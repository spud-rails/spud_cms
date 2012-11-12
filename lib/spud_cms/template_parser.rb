module Spud
  module Cms
    class TemplateParser


      def layouts(site_short_name=nil)
        if(site_short_name != nil)
          return all_layouts.select {|k,v| v[:sites].include?(site_short_name.to_s.downcase)}
        else
          return all_layouts
        end
      end

      def all_layouts
        if @layouts && Rails.env != 'development'
          return @layouts
        end
        @layouts = {}
        engines.each do |engine|
          @layouts.merge! process_layouts(engine.root.join('app','views','layouts'))
        end
        @layouts.merge! process_layouts(Rails.application.root.join('app','views','layouts'))

        check_for_defaults(@layouts)

        return @layouts
      end


  private
      def process_layouts(filepath)
        layouts = {}
        Dir.glob(filepath.join("**","*.html.erb")) do |template|

          layout = process_layout(template)
          layouts[layout_path(template)] = layout if !layout.blank?

        end
        return layouts
      end

      def process_layout(template)
        f = File.open(template)
          header = []
          f.each_line do |line|
            header << line
            break if line.blank?
          end
          f.close
          # puts header
          if header.blank? == false && header[0].strip == "<%"
            layout = {:partials => []}

            header.each do |header_line|
              process_directive(header_line, layout)
            end
            layout[:partials] = ["Body"] if layout[:partials].blank?
            layout[:sites] = [Spud::Core.config.short_name.downcase] if layout[:sites].blank?
            return layout
          end
          return nil
      end

      def check_for_defaults(layouts)
        default_layout_path = layout_path(Rails.application.root.join('app','views','layouts',Spud::Cms.default_page_layout))
        puts("Checking #{default_layout_path}")
        puts(layouts)
        if layouts[default_layout_path].blank?
          layouts[default_layout_path] = {:template_name => "Default", :partials => Spud::Cms.default_page_parts, :sites => [Spud::Core.short_name.downcase], :default => true}
        else
          layouts[default_layout_path][:default] = true
        end

        Spud::Core.multisite_config.each do |config|
          cms_config = Spud::Cms.site_config_for_short_name(config[:short_name])
          layout_path = cms_config.blank? == false && cms_config[:default_page_layout].blank? == false ? layout_path(Rails.application.root.join('app','views','layouts',cms_config[:default_page_layout])) : default_layout_path
          page_parts = cms_config.blank? == false && cms_config[:default_page_parts].blank? == false ? cms_config[:default_page_parts] : Spud::Cms.default_page_parts

          layout = layouts[layout_path]
          if layout.blank?
            layouts[layout_path] = {:template_name => "Default", :partials => page_parts, :sites => [config[:short_name].to_s.downcase], :default => true}
          else
            layout[layout_path][:sites] << config[:short_name].to_s.downcase
            layout[layout_path][:default] = true
          end
        end

      end

      def layout_path(template)
        dir, base = File.split(template)
        path_components = dir.split("/")
        component = path_components.shift
        while component != "layouts" do
          component = path_components.shift
        end
        path_components << base.downcase.split(".")[0]
        return "#{path_components.join("/")}"
      end

      def process_directive(line,layout)
        if template_matcher = line.match(/\#template\_name\:(.*)/)
          layout[:template_name] = template_matcher[1].strip
        end
        if template_matcher = line.match(/\#html\:(.*)/)
          layout[:partials] << template_matcher[1].strip
        end
        if template_matcher = line.match(/\#site_name\:(.*)/)
          layout[:sites] = template_matcher[1].split(",").collect {|s| s.strip.downcase}
        end
      end

      def engines
        Rails::Application::Railties.engines
      end
    end
  end
end
