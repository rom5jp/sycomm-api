class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  self.inheritance_column = :type

  # belongs_to :address
  attr_accessor :skip_password_validation

  validates :name, presence: true
  validates :type, presence: true
  validates :email, format: { with: /@/ }, uniqueness: true
  validates :auth_token, uniqueness: true

  scope :admins, -> { where(type: 'Admin') }
  scope :employees, -> { where(type: 'Employee') }
  scope :customers, -> { where(type: 'Customer') }

  # CALLBACKS
  # before_save :generate_uuid!
  before_save :downcase_email
  before_validation :generate_auth_token!

  def self.types
    %w(Admin Employee Customer)
  end

  def password_required?
    return false if skip_password_validation
    super
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
