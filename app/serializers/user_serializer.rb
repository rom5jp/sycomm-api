class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cpf, :created_at, :updated_at, :type
end
