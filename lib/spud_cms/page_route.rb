Rails.application.routes.draw do
  if Spud::Cms.config.automount
    mount Spud::Cms::Engine, :at => "/"
  end
end
