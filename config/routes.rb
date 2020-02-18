# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root 'static_pages#home'
  get 'search', to: 'users#search'

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

  resources :users, only: %i[show edit update]

  resources :microposts do
    resources :post_photos, only: :destroy
    resources :comments, only: %i[new create destroy]
    resources :likes, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
end
