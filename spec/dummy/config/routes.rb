Rails.application.routes.draw do
  mount Spud::Core::Engine, :at => "/spud"
end
