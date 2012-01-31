FactoryGirl.define do
	sequence :part_name do |n|
	    "Part#{n}"
	end
	factory :spud_page_partial do
		name { Factory.next(:part_name) }
	end
end