Rails.application.routes.draw do
  resources :site
  root 'site#index'
end
