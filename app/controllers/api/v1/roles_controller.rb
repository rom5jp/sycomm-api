class Api::V1::RolesController < Api::V1::BaseApiController
  def index
    roles = Role.all.select(:id, :name, :description)
    render json: roles, status: 200
  end
end
