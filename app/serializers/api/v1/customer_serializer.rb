class Api::V1::CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :registration, :cpf, :landline, :cellphone, :whatsapp, :simple_address, :role, :role_id, :organization, :organization_id, :auth_token, :created_at, :updated_at, :type

  belongs_to :organization
  belongs_to :role
end
