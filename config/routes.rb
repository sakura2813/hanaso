Rails.application.routes.draw do
  get 'symptoms/index'
  get 'symptoms/show'
  devise_for :users
  root to: 'home#index'
  resources :chat_threads, only: [:index, :show, :create] do
    resources :messages, only: :create
  end
  resources :symptoms, only: [:index, :show]
end