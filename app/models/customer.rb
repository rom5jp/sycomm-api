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
      email: email,
      provider: provider,
      name: name,
      surname: surname,
      nickname: nickname,
      registration: registration,
      cpf: cpf,
      landline: landline,
      cellphone: cellphone,
      whatsapp: whatsapp,
      simple_address: simple_address,
      public_agency: public_agency,
      public_office: public_office,
      type: type,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
