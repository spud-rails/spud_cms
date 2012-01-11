Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :pages
   		resources :media
   		resources :menus do
   			resources :menu_items
   		end
   		resources :contacts
   	end
   end
   
   match ":id", "pages#show",:controller => "pages",:action => "show"
end

