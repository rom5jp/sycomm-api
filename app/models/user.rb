class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  include DeviseTokenAuth::Concerns::User

  # belongs_to :address
  attr_accessor :skip_password_validation

  validates :name, presence: true
  validates :type, presence: true
  validates :auth_token, uniqueness: true

  scope :admins, -> { where(type: 'Admin') }
  scope :employees, -> { where(type: 'Employee') }
  scope :customers, -> { where(type: 'Customer') }

  # CALLBACKS
  before_save :generate_uuid!
  before_save :downcase_email
  before_validation :generate_auth_token!

  def password_required?
    return false if skip_password_validation
    super
  end

  # sobrescrita do metodo do devise para poder retornar os valores que quero apos fazer login
  def token_validation_response
    { 
      id: id,
      name: name,
      email: email,
      landline: landline,
      cellphone: cellphone,
      whatsapp: whatsapp,
      simple_address: simple_address,
      auth_token: auth_token,
      created_at: created_at,
      updated_at: updated_at,
      type: type 
  }
  end

  private

  def generate_uuid!
    self.uid = SecureRandom.uuid if self.uid.blank?
  end

  def generate_auth_token!
    self.auth_token = Devise.friendly_token if self.auth_token.blank?
  end

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  
end
