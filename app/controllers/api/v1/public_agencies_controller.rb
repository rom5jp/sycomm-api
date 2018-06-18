class Api::V1::PublicAgenciesController < Api::V1::BaseApiController
  def index
    public_agencies = PublicAgency.all.select(:id, :name, :description)
    render json: public_agencies, status: 200
  end
end
