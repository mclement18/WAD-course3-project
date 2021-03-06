Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'home/index'

  get 'about/index'
  
  resources :users do
    resources :pinboard_pins
  end

  resources :pins do
    resources :comments
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
