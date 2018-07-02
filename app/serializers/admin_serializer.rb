class AdminSerializer < ActiveModel::Serializer
  attributes :id, :name,  :email, :cellphone, :landline, :whatsapp, :created_at, :updated_at, :type
end
