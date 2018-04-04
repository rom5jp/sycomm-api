class State < ApplicationRecord
  validates :name, presence: true
  validates :initials, presence: true
end
