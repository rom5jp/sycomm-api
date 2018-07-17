class Agenda < ApplicationRecord
  belongs_to :employee, class_name: 'Employee'
  has_many :activities
  has_and_belongs_to_many :customers, join_table: 'agendas_customers'

  validates :name, presence: true
  validates :start_date, presence: true
end
