Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :pages
   	end
   end
   
end

