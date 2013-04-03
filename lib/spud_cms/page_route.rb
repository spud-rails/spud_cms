Rails.application.routes.append do
	# constraints :path => /(?!assets)/ do
		get "*id", :controller => "pages",:action => "show", :as => "page"
	# end
end
