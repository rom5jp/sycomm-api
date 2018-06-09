class Employee < User
  has_many :activities

  validates :landline, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :cellphone, presence: true, length: { is: 11 }, numericality: true
  validates :whatsapp, allow_blank: true, length: { minimum: 8 }, numericality: true
end
