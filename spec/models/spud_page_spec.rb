require 'spec_helper'

describe SpudPage do

	it {should have_many(:spud_page_partials)}
	it {should have_many(:spud_pages)}
	it {should belong_to(:spud_page)}
	it {should belong_to(:created_by_user)}
	it {should belong_to(:updated_by_user)}

	describe "validations" do

		it "should require a name" do
			p = FactoryGirl.build(:spud_page,:name => nil)
			p.should_not be_valid
		end

		it "should require a unique url_name" do
			FactoryGirl.create(:spud_page, :url_name => "test", :use_custom_url_name => true)
			t = FactoryGirl.build(:spud_page, :url_name => "test", :use_custom_url_name => true)
			t.should_not be_valid
		end

		it "should generate a url_name if taken" do
			FactoryGirl.create(:spud_page, :name => "test")
			t = FactoryGirl.build(:spud_page, :name => "test")
			lambda {
        t.valid?
      }.should change(t, :url_name)
		end

		it "should dependantly destroy page_partials" do
			t = FactoryGirl.create(:spud_page, :spud_page_partials => [SpudPagePartial.new(:name => "body")])
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

		it "should group pages by parent" do
			parent_page = FactoryGirl.build(:spud_page,:name => "parent")
			parent_page.save

			page = FactoryGirl.build(:spud_page,:name => "Page 1")
			page.spud_page = parent_page
			page.save
			page2 = FactoryGirl.build(:spud_page,:name => "Page 2")
			page2.spud_page = parent_page
			page2.save

			SpudPage.grouped()[parent_page.id].count.should == 2


		end

		it "should return private if visibility is == 1" do
			parent_page = FactoryGirl.build(:spud_page,:name => "parent",:visibility => 1)

			parent_page.is_private?.should == true

			parent_page.visibility = 0
			parent_page.is_private?.should == false
		end


	end

	describe "generate_url_name" do
		it "should add the parent url name if a page has a parent" do
			# Factory(:spud_page, :name => "test")
			parent_page = FactoryGirl.build(:spud_page,:name => "about")
			parent_page.save
			t = FactoryGirl.build(:spud_page, :name => "test")
			t.spud_page = parent_page
			t.valid?

			t.url_name.should == 'about/test'

		end

		it "should add a counter to url_name if the url_name is already in use" do
			page = FactoryGirl.build(:spud_page,:name => "testimonials")
			page.save

			page2 = FactoryGirl.build(:spud_page,:name => "testimonials")
			page2.valid?

			page2.url_name.should == 'testimonials-1'
		end

		it "should add a counter to url_name if the url_name was once in use by another page that was renamed" do
			page = FactoryGirl.build(:spud_page,:name => "another")
			page.save
			page.name = "again"
			page.save

			page2 = FactoryGirl.build(:spud_page,:name => "another")
			page2.valid?

			page2.url_name.should == 'another-1'
		end

		it "should destroy historical permalink if a page is renamed back to its previous name" do
			page = FactoryGirl.build(:spud_page,:name => "permapage")
			page.save

			page.name = 'permapage new'
			page.save

			page.name = 'permapage'

			basecount = SpudPermalink.count

      lambda {
  			page.valid?
      }.should change(page.spud_permalinks.where(:url_name => 'permapage'), :count).from(1).to(0)
		end

		it "should not allow a custom url to be reused by another page" do
			page = FactoryGirl.build(:spud_page,:name => "original")
			page.save

			page = FactoryGirl.build(:spud_page,:name => "new",:use_custom_url_name => true,:url_name => "original")

			page.valid?.should == false
		end

		it "should not allow a custom url to be reused by another page even if it is a historical permalink" do
			page = FactoryGirl.build(:spud_page,:name => "original")
			page.save
			page.name = "original2"
			page.save

			page = FactoryGirl.build(:spud_page,:name => "new")
			page.save
			page.use_custom_url_name = true
			page.url_name = 'original'
			page.valid?.should == false
		end


	end




end
