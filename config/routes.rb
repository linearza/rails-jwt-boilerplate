Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'users#register'
      post 'login', to: 'users#login'

      resources :users, only: [:show, :index, :create, :update]

    end
  end
end
