Rails.application.routes.draw do

  get 'watchlist/new'
  get 'watchlist/create'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post'movies', to: 'movies#search', as: 'movie_search'

  post 'movies/movie', to: 'movies#movie'

  get 'movies/movie', to: 'movies#movie'
  resources :movies, only: [:show] do
    resources :watchlists, only: [:create]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
