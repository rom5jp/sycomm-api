class Customer < Employee
  belongs_to :organization
  belongs_to :role

  validates :cpf, presence: true, length: { is: 11 }
  validates :registration, presence: true, numericality: true

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
      role: role,
      organization: organization,
      auth_token: auth_token,
      created_at: created_at,
      updated_at: updated_at,
      type: type 
  }
  end
end
