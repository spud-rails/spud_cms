Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
         resources :pages do
           get :page_parts, :on => :collection
           get :clear, :on => :collection
         end
         resources :templates 
   		
   		resources :menus do
   			resources :menu_items
   		end
   		resources :contacts
   	end
      namespace :cms do
         resource :sitemap,:only => "show"
      end
   end
   root :to => 'pages#show'
   
   # This is located in lib/spud_cms/page_route.rb to make sure it is loaded last
   # match "*id", :controller => "pages",:action => "show", :as => "page"

end
Spud::Cms::Engine.routes.draw do
end

