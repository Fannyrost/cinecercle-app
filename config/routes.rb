Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post'movies', to: 'movies#search', as: 'movie_search'
  # get 'movies/search'

  resources :movies, only: [:show]






  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
