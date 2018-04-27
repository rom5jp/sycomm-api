require 'api_version_constraint'

Rails.application.routes.draw do
  # devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  namespace :api, path: '/', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do

      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users do
        get :list_paginated, to: 'users#list_paginated', on: :collection
      end

      resources :admins do
        get :list_paginated, to: 'admins#list_paginated', on: :collection
      end

      resources :employees do
        get :list_paginated, to: 'employees#list_paginated', on: :collection
      end

      resources :customers do
        get :list_paginated, to: 'customers#list_paginated', on: :collection
      end

      resources :roles, only: [:index]
      resources :organizations, only: [:index]
    end
  end
end