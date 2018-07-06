class Api::V1::PublicOfficesController < Api::V1::BaseApiController
  def index
    public_offices = PublicOffice.all.select(:id, :name, :description)
    render json: { data: public_offices }, status: 200
  end
end
