require 'spec_helper'

describe SpudTemplate do
	it {should have_many(:spud_pages)}
	describe "validations" do
		it "should require a base layout" do
			t = Factory.build(:spud_template, :base_layout => nil)
			t.valid?.should == false
		end
		it "should require a page_part" do
			t = Factory.build(:spud_template, :page_parts => nil)
			t.valid?.should == false
		end
		it "should require a name" do
			t = Factory.build(:spud_template, :name => nil)
			t.valid?.should == false
		end
		it "should require a unique name" do
			t = Factory.build(:spud_template, :name => "test")
			t.save.should == true
			t = Factory.build(:spud_template, :name => "test")
			t.valid?.should == false
		end
		it "should not destroy pages on destroy" do
			t = Factory.build(:spud_template)
			t.save
			p = Factory.build(:spud_page,:id => 1,:spud_template => t)
			p.save
			t.destroy
			page = SpudPage.find(1)
			page.should == page
		end
	end
end