require 'spec_helper'

describe SpudPageLiquidTag do
    it {should belong_to(:attachment)}
    describe "validations" do
      it "should save if tag is valid" do
        p = FactoryGirl.build(:spud_page_liquid_tag)
        p.should be_valid
      end

      it "should fail if the tag name is blank" do
        p = FactoryGirl.build(:spud_page_liquid_tag, :tag_name => nil)
        p.should_not be_valid
      end

      it "should fail if the attachment is blank" do
        p = FactoryGirl.build(:spud_page_liquid_tag, :attachment_type => nil, :attachment_id => nil)
        p.should_not be_valid
      end

      it "should fail if the value is blank" do
        p = FactoryGirl.build(:spud_page_liquid_tag, :value => nil)
        p.should_not be_valid
      end
    end
end
