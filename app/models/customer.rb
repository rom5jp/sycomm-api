class Customer < Employee
  belongs_to :organization
  belongs_to :role

  validates :registration, numericality: true
end
