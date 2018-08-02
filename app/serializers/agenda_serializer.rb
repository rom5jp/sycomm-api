class AgendaSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :start_date,
             :employee_id,
             :customers_cpf,
             :created_at,
             :updated_at,
             :open_activities_count

  belongs_to :employee
  has_many :customers
  has_many :activities

  def customers_cpf
    object.customers.map { |c| c.cpf }
  end

  def start_date
    object.start_date.strftime '%Y-%m-%d' if object.start_date.present?
  end

  def end_date
    object.end_date.strftime '%Y-%m-%d' if object.end_date.present?
  end

  def open_activities_count
    object.activities.where(status: [:not_started, :in_progress]).count
  end
end
