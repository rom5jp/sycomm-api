class Api::V1::ActivitiesController < ApplicationController
  def list_user_activities
    activities = Activity.where(user: params[:user_id]).limit(5)
    render json: activities, status: 200
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
end
