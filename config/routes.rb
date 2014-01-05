Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
         resources :pages do
           get :page_parts, :on => :collection
           get :clear, :on => :collection
           member do
             post 'preview'
           end
         end

         resources :snippets

   		resources :menus do
   			resources :menu_items do
          put :sort, :on => :collection
        end
   		end
   		resources :contacts
   	end
      namespace :cms do
         resource :sitemap,:only => "show"
      end
   end

   if Spud::Cms.config.root_page_name
     root :to => 'pages#show'
   end

   # This is located in lib/spud_cms/page_route.rb to make sure it is loaded last
   # match "*id", :controller => "pages",:action => "show", :as => "page"

end

