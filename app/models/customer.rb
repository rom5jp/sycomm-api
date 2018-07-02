class Customer < User
  belongs_to :public_agency
  belongs_to :public_office

  validates :cpf, presence: true, length: { is: 11 }
  validates :registration, presence: true, numericality: true
  validates :landline, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :cellphone, presence: true, length: { is: 11 }, numericality: true
  validates :whatsapp, allow_blank: true, length: { minimum: 8 }, numericality: true
end
