Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post'movies', to: 'movies#search', as: 'movie_search'
  get 'movies/search', to: 'movies#search', as: 'movie_home_search'

  post 'movies/movie', to: 'movies#movie'
  get 'movies/movie', to: 'movies#movie'

  get 'profile', to: 'users#profile', as: 'profile'

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

  resources :invitations, only: [:show] do
    patch :accept, on: :member, as: 'accept'
    patch :decline, on: :member, as: 'decline'
  end

  # patch 'invitation/accept', to: 'invitations#accept', as: 'accept_invitation'
  # patch 'invitation/decline', to: 'invitations#decline', as: 'decline_invitation'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
