class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:update, :destroy]

  def index
    users = User.joins('INNER JOIN roles ON roles.id = users.role_id')
                .joins('INNER JOIN organizations ON organizations.id = users.organization_id')
                .select('users.id', 'users.registration', 'users.name', 'users.cpf', 'organizations.name as organization', 'roles.name as role')
                .limit(50)
    render json: users, status: 200
  end

  def show
    begin
      user = User.find(params[:id])
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
    user = current_user
    
    if user.update(user_params)
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
