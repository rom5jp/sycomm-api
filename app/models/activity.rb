class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :agenda

  validates :name, presence: true
  validates :status, presence: true
  validates :activity_type, presence: true
  validates :user, presence: true

  enum activity_type: [:attendance, :offer] # :atendimento, :proposta
  enum status: [:not_started, :in_progress, :finished, :closed] # :nao_iniciado, :em_progresso, :finalizado, :fechado
end
