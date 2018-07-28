class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  include DeviseTokenAuth::Concerns::User

  # belongs_to :address
  attr_accessor :skip_password_validation

  validates :name, presence: true
  validates :type, presence: true

  scope :admins, -> { where(type: 'Admin') }
  scope :employees, -> { where(type: 'Employee') }
  scope :customers, -> { where(type: 'Customer') }

  # CALLBACKS
  before_validation :generate_uuid!, :normalize_email
  before_create :downcase_email
  before_update :strip_simple_address

  def password_required?
    return false if skip_password_validation
    super
  end

  # sobrescrita do metodo do devise para poder retornar os valores que quero apos fazer login
  def token_validation_response
    {
      id: id,
      email: email,
      name: name,
      surname: surname,
      cpf: cpf,
      landline: landline,
      cellphone: cellphone,
      whatsapp: whatsapp,
      simple_address: simple_address,
      created_at: created_at,
      updated_at: updated_at,
      type: type
    }
  end

  private

  def generate_uuid!
    self.uid = SecureRandom.uuid if self.uid.blank?
  end

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def normalize_email
    self.email = self.name.split(' ')[0] + self.registration.to_s +  '@mail.com' if self.email.blank?
    downcase_email
  end

  def strip_simple_address
    if self.simple_address.present?
      puts ">>>>>>>>>>>>>>>>>>>>>> simple_adress antes: '#{self.simple_address}'"
      self.simple_address = self.simple_address.strip
      puts ">>>>>>>>>>>>>>>>>>>>>> simple_adress depois: '#{self.simple_address}'"
    end
  end
end
