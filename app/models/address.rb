class Address < ApplicationRecord
  belongs_to :neighborhood
  belongs_to :city
  belongs_to :state
end
