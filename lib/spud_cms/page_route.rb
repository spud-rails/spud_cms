Rails.application.routes.append do
	# constraints :path => /(?!assets)/ do
		match "*id", :controller => "pages",:action => "show", :as => "page"
	# end
end
