class Agenda < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :name, presence: true
  validates :start_date, presence: true
end
