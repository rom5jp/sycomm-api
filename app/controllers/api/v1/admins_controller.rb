class Api::V1::AdminsController < Api::V1::BaseApiController
  # before_action :set_admin, only: [:show, :update, :destroy]

  def index
  end

  def list_paginated
    page_number = params[:page_number]
    per_page = params[:per_page]

    admins = User.admins
                 .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address'
                  )
                  .order(id: :asc)
                  .page(page_number)
                  .per(per_page)

    response_data = {
        data: admins,
        total_count: admins.count
    }
    render json: response_data, status: 200
  end

  def show
    begin
      admin = User.admins
                  .where(id: params[:id]).select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address'
                  ).first
                  render json: admin, status: 200
    rescue
      head 404
    end
  end

  def create
    admin = User.new(admin_params)
    admin.skip_password_validation = true

    if admin.save
      render json: admin, status: 201
    else
      render json: { errors: admin.errors }, status: 422
    end
  end

  def update
    admin = User.find(admin_params[:id])

    if admin.update_attributes(admin_params)
      render json: admin, status: 200
    else
      render json: { errors: admin.errors }, status: 422
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  private

  def admin_params
    params.require(:admin).permit(
      :id,
      :name,
      :email,
      :cellphone, :whatsapp,
      :simple_address,
      :type
    )
  end
end
