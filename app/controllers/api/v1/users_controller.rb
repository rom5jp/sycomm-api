class Api::V1::UsersController < Api::V1::BaseApiController
  before_action :authenticate_user!

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
                  .joins('INNER JOIN public_offices ON public_offices.id = users.public_office_id')
                  .joins('INNER JOIN public_agencies ON public_agencies.id = users.public_agency_id')
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
                    'public_offices.name as public_office',
                    'public_agencies.name as public_agency'
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

    puts user.public_office
    puts user.public_agency

    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(user_params[:id])

    begin
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
      :password, :password_confirmation,
      :registration,
      :cpf,
      :landline, :cellphone, :whatsapp,
      :simple_address,
      :public_agency_id,
      :public_office_id,
      :type
    )
  end
end
