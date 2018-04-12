class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]
  # before_action :authenticate_with_token!, only: [:update, :destroy]

  def index
    users = User.joins('INNER JOIN roles ON roles.id = users.role_id')
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
                  'organizations.name as organization',
                  'roles.name as role'
                )
                .order(id: :asc)
                .limit(100)
    render json: users, status: 200
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
                'organizations.name as organization',
                'roles.name as role'
              ).first
      render json: user, status: 200
    rescue
      head 404
    end
  end

  def create
    user = User.new(user_params)

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
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :name,
      :email,
      :registration,
      :cpf,
      :landline, :cellphone, :whatsapp,
      :simple_address,
      :password,
      :password_confirmation
    )
  end
end
