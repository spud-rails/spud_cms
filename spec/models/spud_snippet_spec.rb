require 'spec_helper'

describe SpudSnippet do
  it {should have_many(:spud_page_liquid_tags)}

  describe "validations" do
    it "should require a name" do
      p = FactoryGirl.build(:spud_snippet,:name => nil)
      p.should_not be_valid
    end

    it "should require a unique name" do
      Factory(:spud_snippet, :name => "test")

      p = FactoryGirl.build(:spud_snippet, :name => "test")
      p.should_not be_valid
    end
  end

  describe "save_hooks" do
    it "should process content on save" do
      p = FactoryGirl.build(:spud_snippet,:content => "My Test Content")
      p.save
      p.content_processed.should == "My Test Content"
    end

    it "should update tag list on save" do
      Factory(:spud_snippet, :name => "test", :content => "David is Cool")
      p = FactoryGirl.build(:spud_snippet,:content => "{% snippet test %}")
      p.save

      p.spud_page_liquid_tags.count.should == 1

    end
  end

end
