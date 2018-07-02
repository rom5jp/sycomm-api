class CustomerSerializer < ActiveModel::Serializer
  attributes  :id, :name, :email, :registration, :cpf, :landline, :cellphone, :whatsapp, :simple_address, :public_office_id, :public_agency_id, :created_at, :updated_at, :type

  # belongs_to :public_agency
  # belongs_to :public_office
end
