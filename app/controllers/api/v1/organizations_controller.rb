class Api::V1::OrganizationsController < ApplicationController
  def index
    organizations = Organization.all.select(:id, :name)
    render json: organizations, status: 200
  end
end
