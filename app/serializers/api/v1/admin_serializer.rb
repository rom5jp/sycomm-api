class Api::V1::AdminSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at, :type
end
