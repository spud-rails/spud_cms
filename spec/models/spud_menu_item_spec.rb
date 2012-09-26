require 'spec_helper'

describe SpudMenuItem do

  it {should have_many(:spud_menu_items)}
  it {should belong_to(:spud_page)}
  it {should belong_to(:spud_menu)}
  it {should belong_to(:parent)}

  describe :validations do
    it "should require a name" do
      p = Factory.build(:spud_menu_item,:name => nil)
      p.should_not be_valid
    end

    it "should require a menu_id" do
      p = Factory.build(:spud_menu_item,:spud_menu_id => nil)
      p.should_not be_valid
    end

    it "should require a parent_type" do
      p = Factory.build(:spud_menu_item,:parent_type => nil)
      p.should_not be_valid
    end

    it "should require a parent_id" do
      p = Factory.build(:spud_menu_item,:parent_id => nil)
      p.should_not be_valid
    end
  end
end
