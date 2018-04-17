require 'api_version_constraint'

Rails.application.routes.draw do
  # devise_for :users

  namespace :api, path: '/', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users do
        get :list_paginated, to: 'users#list_paginated', on: :collection
      end
      resources :masters do
        get :list_paginated, to: 'masters#list_paginated', on: :collection
      end
      resources :employees do
        get :list_paginated, to: 'employees#list_paginated', on: :collection
      end
      resources :customers do
        get :list_paginated, to: 'customers#list_paginated', on: :collection
      end
      resources :sessions, only: [:create, :destroy]
      resources :roles, only: [:index]
      resources :organizations, only: [:index]
    end
  end
end