class Menu < ActiveRecord::Base
	validates :name,:presence => true
end
