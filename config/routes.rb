Rails.application.routes.draw do
  devise_for :users
  resources :site
  root 'site#index'
end
