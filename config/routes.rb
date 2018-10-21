require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  namespace :api, path: '/', defaults: { format: :json } do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do

      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users do
        get :list_paginated, to: 'users#list_paginated', on: :collection
        get :list_by_type, to: 'users#list_by_type', on: :collection
        get 'get_customer_by_cpf/:cpf', to: 'users#get_customer_by_cpf', on: :collection
        get 'list_employees_with_day_activities', controller: :users, action: :list_employees_with_day_activities, on: :collection
        get 'list_customers_by_agenda', controller: :users, action: :list_customers_by_agenda, on: :collection
        get 'sync_confirme_online', controller: :users, action: :sync_confirme_online, on: :collection
      end

      resources :public_offices do
        get :list_paginated, to: 'public_offices#list_paginated', on: :collection
      end
      resources :public_agencies do
        get :list_paginated, to: 'public_agencies#list_paginated', on: :collection
      end

      resources :activities do
        get 'list_day_activities', controller: :activities, action: :list_day_activities, on: :collection
        get 'list_employee_yesterday_activities', controller: :activities, action: :list_employee_yesterday_activities, on: :collection
        get 'list_employee_day_activities', controller: :activities, action: :list_employee_day_activities, on: :collection
        get 'list_all_paginated', controller: :activities, action: :list_all_paginated, on: :collection
        get 'list_user_activities_paginated', controller: :activities, action: :list_user_activities_paginated, on: :collection
        get 'list_by_agenda_paginated', controller: :activities, action: :list_by_agenda_paginated, on: :collection
      end

      resources :agendas do
        get 'list_all_paginated', controller: :agendas, action: :list_all_paginated, on: :collection
        get 'list_employee_agendas_paginated', controller: :agendas, action: :list_employee_agendas_paginated, on: :collection
        delete 'delete-many', controller: :agendas, action: :delete_many, on: :collection
      end
    end
  end
end