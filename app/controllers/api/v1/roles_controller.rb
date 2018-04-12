class Api::V1::RolesController < ApplicationController
  def index
    roles = Role.all.select(:id, :name)
    render json: roles, status: 200
  end
end
