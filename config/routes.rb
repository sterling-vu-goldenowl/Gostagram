# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'

  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    get '/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users,         only: %i[show edit update]
  resources :microposts,    only: %i[new create destroy show edit update]
  resources :relationships, only: %i[create destroy]
end
