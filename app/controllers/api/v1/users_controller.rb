require 'net/http'
require 'active_support/core_ext'
require 'json'

class Api::V1::UsersController < Api::V1::BaseApiController
  def index
  end

  def list_paginated
    page_number = params[:page_number] || 1
    per_page = params[:per_page] || 10
    sort_field = if params['sortField'].blank? then 'name' else params['sortField'] end
    sort_direction = if params['sortDirection'].blank? then :asc else params['sortDirection'] end
    search_field = if params['searchField'].blank? then 'name' else params['searchField'] end
    search_text = if params['searchText'].blank? then '' else params['searchText'] end
    user_type = params['user_type']
    where_clause = prepare_where_clause(search_field, search_text)
    order_clause = { sort_field => sort_direction }
    rows_count = 0

    case user_type
    when 'Admin'
      users = User.admins
                  .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'users.type')
                  .where(where_clause)
                  .order(order_clause)
                  .page(page_number)
                  .per(per_page)

      rows_count = User.admins.where(where_clause).count
    when 'Employee'
      users = User.employees
                  .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.cpf',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'users.type')
                  .where(where_clause)
                  .order(order_clause)
                  .page(page_number)
                  .per(per_page)

      rows_count = User.employees.where(where_clause).count
    when 'Customer'
      users = User.customers
                  .joins('INNER JOIN public_offices ON public_offices.id = users.public_office_id')
                  .joins('INNER JOIN public_agencies ON public_agencies.id = users.public_agency_id')
                  .select(
                    'users.id',
                    'users.name',
                    'users.email',
                    'users.registration',
                    'users.cpf',
                    'users.landline',
                    'users.cellphone',
                    'users.whatsapp',
                    'users.simple_address',
                    'public_offices.name as public_office',
                    'public_agencies.name as public_agency')
                  .where(where_clause)
                  .order(order_clause)
                  .page(page_number)
                  .per(per_page)

      rows_count = User.customers
                        .joins('INNER JOIN public_offices ON public_offices.id = users.public_office_id')
                        .joins('INNER JOIN public_agencies ON public_agencies.id = users.public_agency_id')
                        .where(where_clause).count
    end

    response_data = {
      data: users,
      total_count: rows_count
    }
    render json: response_data, status: 200
  end

  def list_by_type
    user_type = params['user_type']

    case user_type
      when 'Admin'
        users = User.admins.order(name: :asc)
      when 'Employee'
        users = User.employees.order(name: :asc)
      when 'Customer'
        users = User.customers.order(name: :asc)
    end

    render json: users, status: 200
  end

  def list_customers_by_agenda
    begin
      customers = Agenda.find(params[:agenda_id]).customers
      customers_json = ActiveModel::SerializableResource.new(customers).to_json
      render json: customers_json, status: 200
    rescue Exception => e
      puts e.message
      render json: { errors: e.message }, status: 500
    end
  end

  def show
    user = User.find(params[:id])

    if user.present?
      render json: user, status: 200
    else
      head 404
    end
  end

  def get_customer_by_cpf
    entity = Customer.find_by(cpf: params[:cpf])

    if entity.present?
      render json: entity, status: 200
    else
      head 404
    end
  end

  def create
    user = User.new(user_params)
    user.skip_password_validation = true

    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(user_params[:id])

    begin
      user.update!(user_params)
      render json: user, status: 200
    rescue Exception => msg
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  def list_employees_with_day_activities
    employees_with_day_activities = Employee.distinct.joins(:agendas).where("agendas.start_date = ?", Date.current).order(name: :asc)
    json_result = (ActiveModelSerializers::SerializableResource.new(employees_with_day_activities)).to_json
    render json: json_result, status: 200
  end

  def sync_confirme_online
    operation = confirme_online_params[:OP]
    user = confirme_online_params[:US]
    password = confirme_online_params[:PS]
    sg = confirme_online_params[:SG]
    cc = confirme_online_params[:CC]

    url_text = "http://consulta.confirmeonline.com.br/Integracao/?OP=#{operation}&US=#{user}&PS=#{password}&SG=#{sg}&CC=#{cc}"
    url = URI.parse(url_text)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
    }

    json_response = Hash.from_xml(res.body).to_json

    render json: json_response, status: 200
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :name,
      :email,
      :password, :password_confirmation,
      :registration,
      :cpf,
      :landline, :cellphone, :whatsapp,
      :simple_address,
      :public_agency_id,
      :public_office_id,
      :type
    )
  end

  def confirme_online_params
    params.permit(
      :OP,
      :US,
      :PS,
      :SG,
      :CC
    )
  end

  def prepare_where_clause(search_field, search_text)
    if search_field == 'public_office' or search_field == 'public_agency'
      where_clause = "users.#{search_field}_id = #{search_text}" if search_text.present?
    else
      where_clause = "lower(users.#{search_field}) LIKE ?", "%#{search_text.downcase}%"
    end
  end
end
