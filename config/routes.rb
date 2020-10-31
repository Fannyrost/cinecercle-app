Rails.application.routes.draw do

  get 'movies/search'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post'movies/request', to: 'movies#request', as: 'movie_request'







  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
