class Admin < User
  has_many :activities

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true

  def token_validation_response
    {
      uid: uid,
      id: id,
      email: email,
      provider: provider,
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
end
