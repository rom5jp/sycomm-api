class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # belongs_to :address
  attr_accessor :skip_password_validation

  validates :name, presence: true
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
  
  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
