require 'api_version_constraint'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { subdomain: false }, path: '/' do
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :masters
      resources :employess
      resources :customers
    end
  end
end