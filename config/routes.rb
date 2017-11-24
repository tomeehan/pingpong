Rails.application.routes.draw do
  resources :categories
  resources :matches
  devise_for :users
  resources :site
  root 'site#index'
end
