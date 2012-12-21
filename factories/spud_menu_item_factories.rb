FactoryGirl.define do
  sequence :menu_item_name do |n|
      "Menu Item #{n}"
  end
  factory :spud_menu_item do
    name { FactoryGirl.generate(:menu_item_name) }
    parent_type "SpudMenu"
    parent_id 1
    spud_menu_id 1
  end
end
