class Customer < User
  belongs_to :public_agency
  belongs_to :public_office

  validates :cpf, presence: true, length: { is: 11 }
  validates :registration, presence: true, numericality: true
  validates :landline, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :cellphone, presence: true, length: { is: 11 }, numericality: true
  validates :whatsapp, allow_blank: true, length: { minimum: 8 }, numericality: true

  def token_validation_response
    { 
      id: id,
      name: name,
      email: email,
      cpf: cpf,
      registration: registration,
      landline: landline,
      cellphone: cellphone,
      whatsapp: whatsapp,
      simple_address: simple_address,
      public_office: public_office,
      public_agency: public_agency,
      auth_token: auth_token,
      created_at: created_at,
      updated_at: updated_at,
      type: type 
  }
  end
end
