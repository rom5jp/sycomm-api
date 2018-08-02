class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cpf, :created_at, :updated_at, :type, :last_sign_in_at
end
