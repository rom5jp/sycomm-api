class AgendaSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :start_date,
             :employee_id,
             :customers_cpf,
             :created_at,
             :updated_at

  # belongs_to :employee
  has_many :customers

  def customers_cpf
    object.customers.map { |c| c.cpf }
  end

  def start_date
    object.start_date.strftime '%Y-%m-%d'
  end
end
