PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: [:destroy] do
    member do
      post :vote
    end
    resources :comments do
      member do
        post :vote
      end
    end
  end
  resources :categories, only: [:new, :create, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  resources :users, only: [:new, :create, :edit, :show, :update]
end
