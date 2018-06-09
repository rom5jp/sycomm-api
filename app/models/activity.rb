class Activity < ApplicationRecord
  belongs_to :user, class_name: :Employee

  validates :name, presence: true
  validates :status, presence: true

  enum status: [:not_started, :in_progress, :finished, :closed]
end
