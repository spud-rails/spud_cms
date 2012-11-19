class SpudPageLiquidTag < ActiveRecord::Base
  attr_accessible :attachment_type,:attachment_id, :tag_name, :value
  belongs_to :attachment, :polymorphic => true
end
