require "active_admin"

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'symptoms/index'
  get 'symptoms/show'
  devise_for :users
  root to: 'home#index'
  resources :chat_threads, only: [:index, :show, :create] do
    resources :messages, only: :create
  end
  resources :symptoms do
    post :start_chat, on: :member
  end
end