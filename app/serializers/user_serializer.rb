class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :registration, :cpf, :auth_token, :created_at, :updated_at, :type
end
