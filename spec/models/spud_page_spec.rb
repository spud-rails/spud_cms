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
			p.should_not be_valid
		end

		it "should require a unique url_name" do
			Factory(:spud_page, :url_name => "test", :use_custom_url_name => true)
			t = Factory.build(:spud_page, :url_name => "test", :use_custom_url_name => true)
			t.should_not be_valid
		end

		it "should generate a url_name if taken" do
			Factory(:spud_page, :name => "test")
			t = Factory.build(:spud_page, :name => "test")
			lambda {
        t.valid?
      }.should change(t, :url_name)
		end

		it "should dependantly destroy page_partials" do
			t = Factory(:spud_page, :spud_page_partials => [SpudPagePartial.new()])
      lambda {
  			t.destroy
      }.should change(SpudPagePartial, :count).from(1).to(0)
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