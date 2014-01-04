
module Spud::LiquidTaggable
  extend ActiveSupport::Concern
  included do
	  has_many :spud_page_liquid_tags, :as => :attachment, :dependent => :destroy

  end
end
