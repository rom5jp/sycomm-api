require 'api_version_constraint'

Rails.application.routes.draw do
  # devise_for :users

  namespace :api, path: '/', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: false) do
      resources :masters
      resources :employees
      resources :customers
    end
  end
end