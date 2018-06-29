class Api::V1::EmployeeSerializer < ActiveModel::Serializer
  attributes  :id, :name, :email, :cpf, :landline, :cellphone, :whatsapp, :simple_address, :activities, :created_at, :updated_at, :type
end
