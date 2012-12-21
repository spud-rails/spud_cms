FactoryGirl.define do
  sequence :menu_name do |n|
      "Menu#{n}"
  end
  factory :spud_menu do
    name { FactoryGirl.generate(:menu_name) }
  end
end
