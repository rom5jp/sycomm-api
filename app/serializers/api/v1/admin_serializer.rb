class Api::V1::AdminSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :created_at, :updated_at, :type
end
