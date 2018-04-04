class Address < ApplicationRecord
  belongs_to :neighborhood
  belongs_to :city
  belongs_to :state

  validates :street, presence: true
  validates :number, presence: true
end
