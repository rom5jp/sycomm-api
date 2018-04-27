class Api::V1::OrganizationsController < Api::V1::BaseController
  def index
    organizations = Organization.all.select(:id, :name, :description)
    render json: organizations, status: 200
  end
end
