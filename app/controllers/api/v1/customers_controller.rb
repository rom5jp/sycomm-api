class Api::V1::CustomersController < Api::V1::BaseApiController
  # before_action :set_customer, only: [:show, :update, :destroy]

  def index
  end

  def list_paginated
    page_number = params[:page_number]
    per_page = params[:per_page]

    customers = User.customers
                .joins('INNER JOIN roles ON roles.id = users.role_id')
                .joins('INNER JOIN organizations ON organizations.id = users.organization_id')
                .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.registration',
                    'users.cpf',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'roles.name as role',
                    'organizations.name as organization'
                )
                .order(id: :asc)
                .page(page_number)
                .per(per_page)

    response_data = {
        data: customers,
        total_count: User.count
    }
    render json: response_data, status: 200
  end

  def show
    begin
      customer = User.customers
                 .where(id: params[:id])
                 .joins('INNER JOIN roles ON roles.id = users.role_id')
                 .joins('INNER JOIN organizations ON organizations.id = users.organization_id')
                 .select(
                     'users.id',
                     'users.name',
                     'users.email',
                     'users.registration',
                     'users.cpf',
                     'users.landline',
                     'users.cellphone',
                     'users.whatsapp',
                     'users.simple_address',
                     'organizations.id as organization_id',
                     'roles.id as role_id'
                 ).first
      render json: customer, status: 200
    rescue
      head 404
    end
  end

  def create
    customer = Customer.new(customer_params)
    customer.skip_password_validation = true

    puts customer.role
    puts customer.organization

    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors }, status: 422
    end
  end

  def update
    customer = Customer.find(customer_params[:id])

    if customer.update_attributes(customer_params)
      render json: customer, status: 200
    else
      render json: { errors: customer.errors }, status: 422
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    head 204
  end

  private

  def customer_params
    params.require(:customer).permit(
      :id,
      :name,
      :email,
      :registration,
      :cpf,
      :landline, :cellphone, :whatsapp,
      :simple_address,
      :organization_id,
      :role_id
    )
  end
end
