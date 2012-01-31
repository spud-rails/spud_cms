require 'spec_helper'

describe SpudPage do
	it {should have_many(:spud_page_partials)}
	it {should belong_to(:spud_template)}
	it {should have_many(:spud_pages)}
	it {should belong_to(:spud_page)}
	it {should belong_to(:created_by_user)}
	it {should belong_to(:updated_by_user)}
	describe "validations" do
		it "should require a name" do
			p = Factory.build(:spud_page,:name => nil)
			p.valid?.should == false
		end
		it "should require a unique url_name" do
			t = Factory.build(:spud_page, :url_name => "test",:use_custom_url_name => true)
			t.save
			t = Factory.build(:spud_page, :url_name => "test",:use_custom_url_name => true)
			t.valid?.should == false
		end
		it "should generate a url_name if taken" do
			t = Factory.build(:spud_page, :name => "test")
			t.save
			t = Factory.build(:spud_page, :name => "test")
			t.valid?.should == true
		end
		it "should destroy page_partials on destroy" do
			t = Factory.build(:spud_page)
			t.save
			partial = Factory.build(:spud_page_partial,:spud_page_id => t.id)
			partial.save.should == true
			t.destroy
			SpudPagePartial.count.should == 0
		end
	end
	describe "scopes" do
		it "should only show published pages" do
			SpudPage.published_pages.to_sql.should == SpudPage.where(:published => true).to_sql
		end
		it "should only show parent pages" do
			SpudPage.parent_pages.to_sql.should == SpudPage.where(:spud_page_id => nil).to_sql
		end
		it "should only show public pages" do
			SpudPage.public.to_sql.should == SpudPage.where(:visibility => 0).to_sql
		end
	end

end