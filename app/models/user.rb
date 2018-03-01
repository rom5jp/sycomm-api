class User < ApplicationRecord
  belongs_to :address
  belongs_to :organization
  belongs_to :role

  validates :name, presence: true
  validates :email, presence: true, confirmation: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :registration, numericality: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :cellphone, presence: true
  validates :type, presence: true

  self.inheritance_column = :type

  scope :masters, -> { where(type: 'Master') }
  scope :employees, -> { where(type: 'Employee') }
  scope :customers, -> { where(type: 'Customer') }

  def self.types
    %w(Master Employee Customer)
  end
end
