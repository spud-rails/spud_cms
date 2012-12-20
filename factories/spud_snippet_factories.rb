FactoryGirl.define do
  sequence :snippet_name do |n|
      "Snippet#{n}"
  end
  factory :spud_snippet do
    name { Factory.next(:snippet_name) }
    content "Test Content"
  end
end
