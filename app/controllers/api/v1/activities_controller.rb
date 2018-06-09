class Api::V1::ActivitiesController < ApplicationController
  def list_user_activities
    activities = Activity.where(user: params[:user_id])
    render json: activities, status: 200
  end
end
