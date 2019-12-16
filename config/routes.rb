Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'home/index'

  get 'about/index'
  
  resources :users

  resources :pins
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
