class Api::V1::PublicOfficesController < Api::V1::BaseApiController
  def index
    public_offices = PublicOffice.all.select(:id, :name, :description)
    render json: { data: public_offices }, status: 200
  end

  def list_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10
    sort_field = if params['sortField'].blank? then 'name' else params['sortField'] end
    sort_direction = if params['sortDirection'].blank? then :asc else params['sortDirection'] end
    search_field = if params['searchField'].blank? then 'name' else params['searchField'] end
    search_text = if params['searchText'].blank? then '' else params['searchText'] end
    order_clause = { sort_field => sort_direction }
    where_clause = "lower(public_offices.#{search_field}) LIKE ?", "%#{search_text.downcase}%"

    models_count = 0

    models = PublicOffice.where(where_clause)
                         .order(order_clause)
                         .page(page_number)
                         .per(per_page)

    models_count = PublicOffice.where(where_clause).count

    response_data = {
        data: models,
        total_count: models_count
    }
    render json: response_data, status: 200
  end

  def show
    model = PublicOffice.find(params[:id])

    if model.present?
      render json: model, status: 200
    else
      head 404
    end
  end

  def create
    model = PublicOffice.new(model_params)

    if model.save
      render json: model, status: 201
    else
      render json: { errors: model.errors }, status: 422
    end
  end

  def update
    model = PublicOffice.find(model_params[:id])

    begin
      model.update!(model_params)
      render json: model, status: 200
    rescue Exception => msg
      render json: { errors: model.errors }, status: 422
    end
  end

  def destroy
    PublicOffice.find(params[:id]).destroy
    head 204
  end

  private

  def model_params
    params.require(:public_office).permit(
        :id,
        :name,
        :description,
        )
  end
end
