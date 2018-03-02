class Customer < User
  belongs_to :organization
  belongs_to :role

  validates :registration, numericality: true
end
