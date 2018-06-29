class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cpf, :created_at, :updated_at, :type
end
