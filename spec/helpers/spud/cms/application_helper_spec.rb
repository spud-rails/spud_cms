require 'spec_helper'

describe Spud::Cms::ApplicationHelper do
  before(:each) do
    ActiveRecord::Base.observers.disable(:page_sweeper)


    Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
    end
  end

  describe :sp_list_menu do
    it "should be able to find a menu by its name" do
      menu = FactoryGirl.create(:spud_menu,:name => "Main")
      2.times {|x|  s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")}

      helper.sp_list_menu(:name => "Main",:active_class => "active").should match /\<li/
    end

    it "should assign id to ul block" do
      menu = FactoryGirl.create(:spud_menu)
      2.times {|x|  s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")}

      helper.sp_list_menu(:name => menu.name,:id => "nav").should match /id=\'nav\'/
    end

    it "should render nested menu items" do
      menu = FactoryGirl.create(:spud_menu,:name => "Main2")
      s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s2 = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s3 = FactoryGirl.create(:spud_menu_item,:parent_type => "SpudMenuItem",:parent_id => s.id,:spud_menu_id => menu.id,:url => "/",:name => "SubItem")

      helper.sp_list_menu(:name => "Main2").should match /SubItem/
    end

    it "should respect max depth" do
      menu = FactoryGirl.create(:spud_menu,:name => "Main4")
      s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s2 = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s3 = FactoryGirl.create(:spud_menu_item,:parent_type => "SpudMenuItem",:parent_id => s.id,:spud_menu_id => menu.id,:url => "/",:name => "SubItem")

      helper.sp_list_menu(:name => "Main4",:max_depth => 1).should_not match /SubItem/
    end

    it "should not load menu from different site_id" do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = true
        config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
      end
      menu = FactoryGirl.create(:spud_menu,:site_id => 0)
      s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")

      helper.sp_list_menu(:name => menu.name).should be_blank

    end
  end

  describe :sp_menu_with_seperator do
    it "should render a flattened list of links" do
      menu = FactoryGirl.create(:spud_menu,:name => "Main3")
      s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s2 = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      s3 = FactoryGirl.create(:spud_menu_item,:parent_type => "SpudMenuItem",:parent_id => s.id,:spud_menu_id => menu.id,:url => "/",:name => "SubItem")

      content = helper.sp_menu_with_seperator(:name => "Main3")
      content.should match /SubItem/
      content.should_not match /\<li/
    end

    it "should not load menu from different site_id" do

      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = true
        config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
      end
      menu = FactoryGirl.create(:spud_menu,:site_id => 0)
      s = FactoryGirl.create(:spud_menu_item,:parent_id => menu.id,:spud_menu_id => menu.id,:url => "/")
      helper.sp_menu_with_seperator(:name => menu.name).should be_blank

    end


  end

  describe :sp_list_pages do
    it "should be able to list created pages" do
      page = FactoryGirl.create(:spud_page)
      page2 = FactoryGirl.create(:spud_page)
      page3 = FactoryGirl.create(:spud_page,:spud_page_id => page.id)


      content = helper.sp_list_pages(:active_class => "active")
      content.should match /#{page.name}/
      content.should match /#{page2.name}/
      content.should match /#{page3.name}/
    end

    it "should assign id" do
      page = FactoryGirl.create(:spud_page)
      page2 = FactoryGirl.create(:spud_page)

      content = helper.sp_list_pages(:id => "page_nav")
      content.should match /id=\'page_nav\'/

    end

    it "should be able to exclude certain pages" do
      page = FactoryGirl.create(:spud_page)
      page2 = FactoryGirl.create(:spud_page)

      content = helper.sp_list_pages(:exclude => [page2.name])
      content.should match /#{page.name}/
      content.should_not match /#{page2.name}/
    end
    it "should respect max depth" do
      page = FactoryGirl.create(:spud_page)
      page2 = FactoryGirl.create(:spud_page)
      page3 = FactoryGirl.create(:spud_page,:spud_page_id => page.id)


      content = helper.sp_list_pages(:max_depth => 1)
      content.should match /#{page.name}/
      content.should match /#{page2.name}/
      content.should_not match /#{page3.name}/
    end


    it "should be able to list sub pages of a particular page" do
      page = FactoryGirl.create(:spud_page)
      page2 = FactoryGirl.create(:spud_page)
      page3 = FactoryGirl.create(:spud_page,:spud_page_id => page.id)
      content = helper.sp_list_pages(:start_page_id => page.id)
      content.should_not match /#{page.name}/
      content.should_not match /#{page2.name}/
      content.should match /#{page3.name}/
    end

    it "should not load pages from different site_id" do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = true
        config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
      end
      page = FactoryGirl.create(:spud_page,:site_id => 0)
      page2 = FactoryGirl.create(:spud_page,:site_id => 1)

      content = helper.sp_list_pages()
      content.should_not match /#{page.name}/
      content.should match /#{page2.name}/

    end


  end
end
