class User < ApplicationRecord
  self.inheritance_column = :type

  scope :masters, -> { where(type: 'Master') }
  scope :employees, -> { where(type: 'Employee') }
  scope :customers, -> { where(type: 'Customer') }

  def self.types
    %w(Master Employee Customer)
  end
end
