Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :chats, only: [:index, :show, :new] do
    resources :messages, only: [:create]
  end
end
