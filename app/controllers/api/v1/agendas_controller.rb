class Api::V1::AgendasController < Api::V1::BaseApiController
  def list_all_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10
    sort_field = if params['sortField'].blank? then 'name' else params['sortField'] end
    sort_direction = if params['sortDirection'].blank? then :asc else params['sortDirection'] end
    search_field = if params['searchField'].blank? then 'name' else params['searchField'] end
    search_text = if params['searchText'].blank? then '' else params['searchText'] end
    where_clause = prepare_where_clause(search_field, search_text)
    order_clause = { sort_field => sort_direction }

    agendas = Agenda.order(id: :asc)
                    .where(where_clause)
                    .order(order_clause)
                    .page(page_number)
                    .per(per_page)

    response_data = {
      data: ActiveModel::SerializableResource.new(agendas),
      total_count: Agenda.where(where_clause).count
    }
    render json: response_data, status: 200
  end


  def list_employee_agendas_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10

    agendas = Agenda.where(employee_id: params[:employee_id])
                    .page(page_number)
                    .per(per_page)
                    .order(id: :asc)

    response_data = {
      data: ActiveModel::SerializableResource.new(agendas),
      total_count: Agenda.where(employee: params[:employee_id]).count
    }
    render json: response_data, status: 200
  end

  def show
    entity = Agenda.find(params[:id])

    if entity.present?
      render json: entity, status: 200
    else
      head 404
    end
  end

  def create
    entity = Agenda.new(name: agenda_params[:name],
                        start_date: agenda_params[:start_date],
                        end_date: agenda_params[:end_date],
                        employee_id: agenda_params[:employee_id])
    customers_cpf_param = params[:customers_cpf]

    if customers_cpf_param.present?
      retrieved_customers = []

      customers_cpf_param.each do |cpf|
        retrieved_customer = Customer.find_by(cpf: cpf)

        begin
          retrieved_customer.save!
        rescue Exception => msg
          error_message = "Não foi possível atualizar esta Agenda porque o Cliente '#{retrieved_customer.name}' possui dados inconsistentes, como segue: <br><br> #{msg.to_s}. <br><br> Por favor, corrija os dados deste Cliente e em seguida tente atualizar a Agenda novamente."
          render json: { message: error_message }, status: 422
          return
        end
        retrieved_customers << retrieved_customer
      end

      entity.customers = retrieved_customers
    end

    begin
      entity.save!
      render json: entity, status: 201
    rescue Exception => msg
      puts " >>> Erro ao criar agenda: #{msg}"
      render json: { errors: entity.errors }, status: 422
    end
  end

  def update
    entity = Agenda.find(params[:id])
    customers_param = params[:customers]

    entity.name = params[:name]
    entity.start_date = params[:start_date]
    entity.end_date = params[:end_date]

    if entity.employee_id != params[:employee_id]
      entity.employee_id = params[:employee_id]

      entity.activities.each do |activity|
        activity.update(employee_id: params[:employee_id])
      end
    end

    if customers_param.present?
      retrieved_customers = []
      customers_param.each do |customer|
        retrieved_customer = Customer.find(customer['id'])

        begin
          retrieved_customer.save!
        rescue Exception => msg
          error_message = "Não foi possível atualizar esta Agenda porque o Cliente '#{retrieved_customer.name}' possui dados inconsistentes, como segue: <br><br> #{msg.to_s}. <br><br> Por favor, corrija os dados deste Cliente e em seguida tente atualizar a Agenda novamente."
          render json: { message: error_message }, status: 422
          return
        end

        retrieved_customers << retrieved_customer
      end
      entity.customers = retrieved_customers
    elsif customers_param.count == 0
      entity.customers.clear
    end

    begin
      entity.save!
      render json: entity, status: 200
    rescue Exception => msg
      puts " >>> Erro ao criar agenda: #{msg}"
      render json: { errors: entity.errors }, status: 422
    end
  end

  def destroy
    begin
      Agenda.find(agenda_params[:id]).destroy!
      head 204
    rescue
      render nothing: true, status: 404
    end
  end

  def delete_many
    agendas_ids = params['agendas_ids'].split(",").map { |id| id.to_i }
    begin
      Agenda.where(id: agendas_ids).each { |agenda| agenda.destroy! }
      head 204
    rescue Exception => e
      puts e.message
      render json: e.message, status: 500
    end
  end

  private

  def agenda_params
    params.permit(
      :id,
      :name,
      :start_date,
      :end_date,
      :employee_id,
      customers_cpf: [],
      agendas_ids: []
    )
  end

  def prepare_where_clause(search_field, search_text)
    where_clause = "lower(agendas.#{search_field}) LIKE ?", "%#{search_text.downcase}%"
  end
end
