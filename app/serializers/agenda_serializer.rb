class AgendaSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :created_at, :updated_at

  belongs_to :user
end
