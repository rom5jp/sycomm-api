class Customer < User
  belongs_to :public_agency
  belongs_to :public_office
  has_and_belongs_to_many :agendas, join_table: 'agendas_customers'

  validates :cpf, presence: true, length: { is: 11 }
  validates :registration, presence: true, numericality: true
  validates :landline, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :cellphone, presence: true, length: { is: 11 }, numericality: true
  validates :whatsapp, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :agendas, uniqueness: true
end
