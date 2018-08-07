class Agenda < ApplicationRecord
  belongs_to :employee, class_name: 'Employee', foreign_key: 'employee_id'
  has_many :activities, dependent: :destroy
  has_and_belongs_to_many :customers, join_table: 'agendas_customers'

  validates :name, presence: true
end
