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
    order_clause = { sort_field => sort_direction }
    where_clause = "users.#{search_field} LIKE ?", "%#{search_text}%"

    users_count = 0

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

      users_count = User.admins.where(where_clause).count
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

      users_count = User.employees.where(where_clause).count
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

      users_count = User.customers
                        .joins('INNER JOIN public_offices ON public_offices.id = users.public_office_id')
                        .joins('INNER JOIN public_agencies ON public_agencies.id = users.public_agency_id')
                        .where(where_clause).count
    end

    response_data = {
      data: users,
      total_count: users_count
    }
    render json: response_data, status: 200
  end

  def list_by_type
    user_type = params['user_type']

    case user_type
      when 'Admin'
        users = User.admins
      when 'Employee'
        users = User.employees
      when 'Customer'
        users = User.customers
    end

    render json: users, status: 200
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
    json_result = (ActiveModel::SerializableResource.new(employees_with_day_activities)).to_json
    render json: json_result, status: 200
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
end
