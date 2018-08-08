class Api::V1::ActivitiesController < Api::V1::BaseApiController
  def list_all_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    activities = Activity.order(id: :asc)
                         .page(page_number)
                         .per(per_page)

    response_data = {
        data: ActiveModel::SerializableResource.new(activities),
        total_count: Activity.count
    }
    render json: response_data, status: 200
  end

  def list_day_activities
    agendas = Agenda.where(start_date: Date.current).includes(:activities)
    activities = agendas.map { |agenda| agenda.activities }.flatten!
    render json: { data: ActiveModel::SerializableResource.new(activities) }, status: 200
  end

  def list_employee_yesterday_activities
    agendas = Agenda.where(employee: params[:employee_id], start_date: Date.yesterday).includes(:activities)
    activities = agendas.map { |agenda| agenda.activities.where(status: [1,2]) }.flatten!

    render json: { data: ActiveModel::SerializableResource.new(activities) }, status: 200
  end

  def list_employee_day_activities
    agendas = Agenda.where(employee: params[:employee_id], start_date: Date.current)

    activities = agendas.map do |agenda|
      agenda.activities
    end

    activities.flatten!

    render json: { data: ActiveModel::SerializableResource.new(activities) }, status: 200
  end

  def list_user_activities_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    activities = Activity.where(employee: params[:employee_id])
                         .order(id: :asc)
                         .page(page_number)
                         .per(per_page)

    response_data = {
      data: ActiveModel::SerializableResource.new(activities),
      total_count: Activity.where(employee: params[:employee_id]).count
    }
    render json: response_data, status: 200
  end

  def list_by_agenda_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    activities = Activity.where(agenda_id: params[:agenda_id])
                       .order(id: :asc)
                       .page(page_number)
                       .per(per_page)

    total_count = Activity.where(agenda_id: params[:agenda_id]).count

    response_data = {
        data: ActiveModel::SerializableResource.new(activities),
        total_count: total_count
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

  def create
    entity = Activity.new(activity_params)
    entity.agenda = Agenda.find(params[:agenda_id])

    if entity.save
      render json: entity, status: 201
    else
      render json: { errors: entity.errors }, status: 422
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

  def destroy
    begin
      Activity.find(params[:id]).destroy!
      head 204
    rescue
      render nothing: true, status: 404
    end
  end

  def activity_params
    params.require(:activity).permit(
      :id,
      :name,
      :description,
      :annotations,
      :status,
      :activity_type,
      :customer_id,
      :customer_name,
      :employee_id,
      :created_at,
      :updated_at
    )
  end
end
