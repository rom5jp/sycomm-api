class Api::V1::AgendasController < Api::V1::BaseApiController
  def list_all_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    agendas = Agenda.order(id: :asc)
                     .page(page_number)
                     .per(per_page)

    response_data = {
        data: agendas,
        total_count: Agenda.count
    }
    render json: response_data, status: 200
  end

  def list_user_agendas_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    agendas = Agenda.order(id: :asc)
                    .page(page_number)
                    .per(per_page)

    response_data = {
        data: agendas,
        total_count: Agenda.where(employee: params[:employee_id]).count
    }
    render json: response_data, status: 200
  end

  def create
    if entity.save
      render json: entity, status: 201
    else
      render json: { errors: entity.errors }, status: 422
    end
  end

  def show
    entity = Agenda.find(params[:id])

    if entity.present?
      render json: entity, status: 200
    else
      head 404
    end
  end

  def update
    entity = Agenda.find(params[:id])
    customers_cpf = params[:customers_cpf]

    entity.name = params[:name]
    entity.start_date = params[:start_date]
    entity.employee_id = params[:employee_id]

    if customers_cpf.present?
      customers_cpf.each do |cpf|
        cust = Customer.find_by(cpf: cpf)
        entity.customers << cust
      end
    end

    begin
      entity.save!
      render json: entity, status: 200
    rescue Exception => msg
      render json: { errors: entity.errors }, status: 422
    end
  end

  def agenda_params
    params.permit(
        :id,
        :name,
        :start_date,
        :employee_id,
        :customers_cpf,
        :created_at,
        :updated_at
    )
  end
end
