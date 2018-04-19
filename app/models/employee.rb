class Employee < User
  validates :cpf, presence: true, length: { is: 11 }
end
