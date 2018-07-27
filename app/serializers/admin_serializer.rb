class AdminSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :email, :cpf, :cellphone, :landline, :whatsapp, :created_at, :updated_at, :type
end
