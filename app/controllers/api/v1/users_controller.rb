class Api::V1::UsersController < Api::V1::BaseApiController
  # before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  respond_to :json

  def index
    cu = current_user
    puts " >>>>>>>>>>>>>>> current_user: #{current_user.name}"
    puts " >>>>>>>>>>>>>>> user_logged_in? #{user_logged_in?}"
    render json: cu, status: 200
  end

  def list_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    users = User.joins('INNER JOIN roles ON roles.id = users.role_id')
                .joins('INNER JOIN organizations ON organizations.id = users.organization_id')
                .select(
                  'users.id',
                  'users.name',
                  
                  'users.type as user_type',
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
      data: users,
      total_count: User.count
    }
    render json: response_data, status: 200
  end

  def show
    begin
      user = User.where(id: params[:id])
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
      render json: user, status: 200
    rescue
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

    if user.update_attributes(user_params)
        render json: user, status: 200
    else
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
      :type
    )
  end
end
