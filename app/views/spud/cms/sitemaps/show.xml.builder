
xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'

# create the urlset
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @pages.each do |page|
    xml.url do
      if page.url_name == Spud::Cms.root_page_name
        xml.loc root_url()
      else
        xml.loc page_url(:id => page.url_name)
      end
      xml.lastmod page.updated_at.strftime('%Y-%m-%d')
    end
  end
end