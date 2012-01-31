module Spud
  module Cms
    module TestFiles
      class << self
        def load_all
          load_specs
          load_factories
          load_support
        end
        
        def load_specs
          Dir[File.join(File.expand_path('../../../', __FILE__), "spec/**/*_spec.rb")].each {|f| require f}
        end
          
        def load_factories
          Dir[File.join(File.expand_path('../../../', __FILE__), "factories/*")].each {|f| require f}
        end
        
        def load_support
          Dir[File.join(File.expand_path('../../../', __FILE__), "spec/support/**/*.rb")].each {|f| require f}
        end
      end
    end
  end
end
