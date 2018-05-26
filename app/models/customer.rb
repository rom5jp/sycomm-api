class Customer < Employee
  belongs_to :organization
  belongs_to :role

  validates :cpf, presence: true, length: { is: 11 }
  validates :registration, numericality: true
end
