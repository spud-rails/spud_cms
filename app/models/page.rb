class Page < ActiveRecord::Base
	belongs_to :page
	has_many :pages
	has_many :custom_fields,:as => :parent,:dependent => :destroy
	belongs_to :created_by_user,:class_name => "SpudUser",:foreign_key => :created_by
	belongs_to :updated_by_user,:class_name => "SpudUser",:foreign_key => :updated_by
	validates :name,:presence => true
	

end
