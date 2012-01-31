FactoryGirl.define do
	sequence :page_name do |n|
	    "Page#{n}"
	end
	factory :spud_page do
		name { Factory.next(:page_name) }
		published true
	end
end