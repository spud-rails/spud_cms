class SpudPageLiquidTag < ActiveRecord::Base
  attr_accessible :spud_page_partial_id, :tag_name, :value
  belongs_to :attachment, :polymorphic => true
end
