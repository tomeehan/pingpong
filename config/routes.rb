Rails.application.routes.draw do
  resources :matches
  devise_for :users
  resources :site
  root 'site#index'
end
