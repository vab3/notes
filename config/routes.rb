# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :notes
  resources :users
  root to: 'notes#index'
end
