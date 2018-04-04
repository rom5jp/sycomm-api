class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  def index
    customers = Customer.all.limit(10)
    render json: customers, status: 200
  end

  def show
    begin
      customer = Customer.find(params[:id])
      render json: customer, status: 200
    rescue
      head 404
    end
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors }, status: 422
    end
  end

  def update
    if @customer
      if @customer.update_attributes(customer_params)
        render json: @customer, status: 200
      else
        render json: { errors: @customer.errors }, status: 422
      end
    else
      render json: { errors: customer_params.errors }, status: 404
    end
  end

  def destroy
    render(nothing: true, status: 204) if @customer.destroy
  end

  private

  def set_customer
    begin
      @customer = Customer.find(params[:id])
    rescue
      head 404
    end
  end
end
