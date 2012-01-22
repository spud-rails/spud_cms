Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   	  resources :pages do
        get :page_parts, :on => :member
      end
      resources :templates 
   		resources :media
   		resources :menus do
   			resources :menu_items
   		end
   		resources :contacts
   	end
   end
   root :to => 'pages#show'
   match ":id", :controller => "pages",:action => "show", :as => "page"
end

