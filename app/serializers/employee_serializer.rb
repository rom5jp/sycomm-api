class EmployeeSerializer < ActiveModel::Serializer
  attributes  :id, :name, :email, :cpf, :landline, :cellphone, :whatsapp, :simple_address, :created_at, :updated_at, :type
end
