Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      # post 'register', to: 'users#register'
      post 'login', to: 'users#login'

      get 'users/me', to: 'users#me' # get current_user
      resources :users, only: [:show, :index, :create, :update]

      put '/users/:id/confirm-user', to: 'users#confirm_user', defaults: {format: :json}
      put '/users/:id/deconfirm-user', to: 'users#deconfirm_user', defaults: {format: :json}

    end
  end
end
