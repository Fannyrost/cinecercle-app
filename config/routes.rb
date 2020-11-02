Rails.application.routes.draw do

  get 'users/profile'
  get 'circle/new'
  get 'circle/index'
  get 'circle/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post'movies', to: 'movies#search', as: 'movie_search'
  post 'movies/movie', to: 'movies#movie'
  get 'movies/movie', to: 'movies#movie'

  resources :movies, only: [:show] do
    resources :watchlists, only: [:create, :destroy]
    resources :recommendations, only: [:create]
  end

  resources :circles, only: [:index, :show, :new, :create] do
    get 'movies', to: 'movies#search', as: 'movie_search'
    resources :invitations, only: [:new, :create]
    resources :recommendations, only: [:show] do
      resources :watchlists, only: [:create, :destroy]
    end
  end

  resources :users, only: [:show]
  get 'profile', to: 'users#profile', as: 'profile'



  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
