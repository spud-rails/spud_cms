class SpudPageLiquidTag < ActiveRecord::Base
  belongs_to :attachment, :polymorphic => true, :touch => true
end
