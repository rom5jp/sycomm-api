class Api::V1::EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cpf, :landline, :cellphone, :whatsapp, :auth_token, :created_at, :updated_at, :type
end
