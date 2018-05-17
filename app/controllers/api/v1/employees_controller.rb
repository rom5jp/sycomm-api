class Api::V1::EmployeesController < Api::V1::BaseApiController
  respond_to :json

  def index
  end

  def list_paginated
    page_number = params[:page_number]
    per_page = params[:per_page]

    employees = User.employees.select(
                  'users.id',
                  'users.name',
                  'users.email',
                  'users.cpf',
                  'users.landline',
                  'users.cellphone',
                  'users.whatsapp',
                  'users.simple_address'
                )
                .order(id: :asc)
                .page(page_number)
                .per(per_page)

    response_data = {
        data: employees,
        total_count: Employee.count
    }
    render json: response_data, status: 200
  end

  def show
    begin
      employee = User.employees.where(id: params[:id]).select(
                   'users.id',
                   'users.name',
                   'users.email',
                   'users.cpf',
                   'users.landline',
                   'users.cellphone',
                   'users.whatsapp',
                   'users.simple_address'
                 ).first
      render json: employee, status: 200
    rescue
      head 404
    end
  end

  def create
    employee = Employee.new(employee_params)
    employee.skip_password_validation = true

    if employee.save
      render json: employee, status: 201
    else
      render json: { errors: employee.errors }, status: 422
    end
  end

  def update
    employee = Employee.find(employee_params[:id])

    if employee.update_attributes(employee_params)
      render json: employee, status: 200
    else
      render json: { errors: employee.errors }, status: 422
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    head 204
  end

  private

  def employee_params
    params.require(:employee).permit(
        :id,
        :name,
        :email,
        :cpf,
        :landline, :cellphone, :whatsapp,
        :simple_address,
        :type
    )
  end
end
