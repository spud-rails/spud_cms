Rails.application.routes.append do
	match "*id", :controller => "pages",:action => "show", :as => "page"
end