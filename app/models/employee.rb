class Employee < User
  has_many :activities

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true
  validates :landline, allow_blank: true, length: { minimum: 8 }, numericality: true
  validates :cellphone, presence: true, length: { is: 11 }, numericality: true
  validates :whatsapp, allow_blank: true, length: { minimum: 8 }, numericality: true

  def token_validation_response
    {
      uid: uid,
      id: id,
      email: email,
      provider: provider,
      name: name,
      surname: surname,
      nickname: nickname,
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
