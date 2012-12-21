class SpudPageLiquidTag < ActiveRecord::Base
  attr_accessible :attachment_type,:attachment_id, :tag_name, :value
  belongs_to :attachment, :polymorphic => true

  validates :tag_name,:presence => true
  validates :attachment_type, :presence => true
  validates :attachment_id, :presence => true
  validates :value, :presence => true
end
