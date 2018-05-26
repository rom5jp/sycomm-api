class Api::V1::UsersController < Api::V1::BaseApiController
  # respond_to :json

  def index
  end

  def list_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    user_type = params['user_type']

    case user_type
    when 'Admin'
      users = User.admins
                  .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'users.type'
                  )
                  .order(id: :asc)
                  .page(page_number)
                  .per(per_page)
    when 'Employee'
      users = User.employees
                  .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.cpf',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'users.type'
                  )
                  .order(id: :asc)
                  .page(page_number)
                  .per(per_page)
    when 'Customer'
      users = User.customers
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
    end

    response_data = {
      data: users,
      total_count: User.where(type: user_type).count
    }
    render json: response_data, status: 200
  end

  def show
    user = User.find(params[:id])

    if user.present?
      render json: user, status: 200
    else
      head 404
    end
  end

  def create
    user = User.new(user_params)
    user.skip_password_validation = true

    puts user.role
    puts user.organization

    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(user_params[:id])

    begin
      puts " >>>>> #{user.type}"
      user.update!(user_params)
      render json: user, status: 200
    rescue Exception => msg
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :name,
      :email,
      :password,
      :password_confirmation,
      :registration,
      :cpf,
      :landline, :cellphone, :whatsapp,
      :simple_address,
      :organization_id,
      :role_id,
      :user_type
    )
  end
end
