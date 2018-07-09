require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  namespace :api, path: '/', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do

      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users do
        get :list_paginated, to: 'users#list_paginated', on: :collection
        get :list_by_type, to: 'users#list_by_type', on: :collection
      end

      resources :public_offices, only: [:index]
      resources :public_agencies, only: [:index]

      resources :activities, only: [:show, :create, :update] do
        get 'list_last_user_activities', controller: :activities, action: :list_last_user_activities, on: :collection
        get 'list_user_activities_paginated', controller: :activities, action: :list_user_activities_paginated, on: :collection
      end

      resources :agendas do
      end
    end
  end
end