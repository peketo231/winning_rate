Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'mypage', to: 'users#show'
  resources :users, only: %i[new create]

  get 'battle_records/:name', to: 'battle_records#new'
  resources :battle_records, only: %i[create]

  resources :monthlies, only: %i[index]
end
