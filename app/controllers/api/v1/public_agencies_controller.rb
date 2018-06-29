class Api::V1::PublicAgenciesController < Api::V1::BaseApiController
  before_action :authenticate_user!

  def index
    public_agencies = PublicAgency.all.select(:id, :name, :description)
    render json: { data: public_agencies }, status: 200
  end
end
