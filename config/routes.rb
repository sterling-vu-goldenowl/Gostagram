# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    get '/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
  end
  resources :users, only: %i[show edit update]
  devise_for :users, controllers: { registrations: 'users/registrations' }
end
