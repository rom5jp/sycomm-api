class Employee < User
  validates :landline, length: { is: 11 }, allow_blank: true
  validates :cellphone, presence: true, length: { is: 11 }
  validates :whatsapp, length: { is: 11 }, allow_blank: true
end
