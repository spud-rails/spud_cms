Rails.application.routes.draw do
	# constraints :path => /(?!assets)/ do
		get "*id", :controller => "pages",:action => "show", :as => "page"
	# end
end
