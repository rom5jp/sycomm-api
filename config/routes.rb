require 'api_version_constraint'

Rails.application.routes.draw do
  # devise_for :users

  namespace :api, path: '/', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users do
        get :get_all_paginated, to: 'users#get_all_paginated', on: :collection
      end
      resources :masters
      resources :employees
      resources :customers
      resources :sessions, only: [:create, :destroy]
      resources :roles, only: [:index]
      resources :organizations, only: [:index]
    end
  end
end