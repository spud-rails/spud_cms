FactoryGirl.define do
	sequence :name do |n|
	    "Template#{n}"
	end
	factory :spud_template do
		name { Factory.next(:name) }
		base_layout Spud::Cms.default_page_layout
		page_parts Spud::Cms.default_page_parts.join(",")
	end
end