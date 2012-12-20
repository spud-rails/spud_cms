Spud::Core::Engine.routes.draw do
  scope :module => "spud" do
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
   			resources :menu_items
   		end
   		resources :contacts
   	end

    namespace :cms do
       resource :sitemap
    end
  end

   # This is located in lib/spud_cms/page_route.rb to make sure it is loaded last
   # match "*id", :controller => "pages",:action => "show", :as => "page"
end

Spud::Cms::Engine.routes.draw do
     root :to => 'pages#show'
     match "*id", :controller => "pages",:action => "show", :as => "page"
end





