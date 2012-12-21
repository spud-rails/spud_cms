require 'spec_helper'

describe SpudPagePartial do
  describe "validations" do

    it "should require a name" do
      p = FactoryGirl.build(:spud_page_partial,:name => nil)
      p.should_not be_valid
    end

    it "should respond with a symbol_name based on name" do
      p = FactoryGirl.build(:spud_page_partial,:name => "Test Page")
      p.symbol_name.should == "test_page"
    end
  end

  describe "save hooks" do
    it "should save the symbol name" do
      p = Factory.create(:spud_page_partial,:name => "Test Page")
      p.attributes["symbol_name"].should == "test_page"
    end

    it "should create a new revision if content is changed" do
      p = Factory.create(:spud_page_partial,:name => "Test Page",:content =>"Home Sweet Home",:spud_page_id => 1)
      SpudPagePartialRevision.where(:spud_page_id => 1,:name => "Test Page").count.should == 1
    end

    it "should delete old revisions beyond max_revision count" do
      Spud::Cms.configure do |config|
        config.max_revisions = 2
      end
      p = Factory.create(:spud_page_partial,:name => "Test Page",:content =>"Home Sweet Home",:spud_page_id => 1)
      p.content = "Nah"
      p.save

      p.content = "Another change"
      p.save
      SpudPagePartialRevision.where(:spud_page_id => 1,:name => "Test Page").count.should == 2
    end

  end


end
