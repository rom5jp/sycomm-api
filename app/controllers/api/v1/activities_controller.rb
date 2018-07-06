class Api::V1::ActivitiesController < Api::V1::BaseApiController
  def list_last_user_activities
    activities = Activity.where(user: params[:user_id]).limit(params[:quant])

    render json: { data: activities }, status: 200
  end

  def list_user_activities_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    activities = Activity
                  .order(id: :asc)
                  .page(page_number)
                  .per(per_page)

    response_data = {
      data: activities,
      total_count: Activity.where(user: params[:user_id]).count
    }
    render json: response_data, status: 200
  end

  def show
    entity = Activity.find(params[:id])

    if entity.present?
      render json: entity, status: 200
    else
      head 404
    end
  end

  def update
    act = Activity.find(activity_params[:id])

    begin
      act.update!(activity_params)
      render json: act, status: 200
    rescue Exception => msg
      render json: { errors: act.errors }, status: 422
    end
  end

  def activity_params
    params.require(:activity).permit(
      :id,
      :name,
      :annotations,
      :status,
      :activity_type,
      :client_id,
      :client_name,
      :user_id,
      :created_at,
      :updated_at
    )
  end
end
