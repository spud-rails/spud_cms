require 'liquid'
module Spud
  module Cms
    class LiquidSnippet < Liquid::Tag
      def initialize(tag_name, snippet_name, tokens)
        @snippet_name = snippet_name
        @snippet = SpudSnippet.where(:name => snippet_name).first

      end

      def tag_name
        return "snippet"
      end
      def tag_value
        return @snippet_name
      end

      def render(context)

        if !@snippet.blank?
          return @snippet.content_processed.html_safe
        else
          return ''
        end

      end
    end
  end
end
