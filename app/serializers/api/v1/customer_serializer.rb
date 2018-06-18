class Api::V1::CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :registration, :cpf, :landline, :cellphone, :whatsapp, :simple_address, :public_office, :public_office_id, :public_agency, :public_agency_id, :auth_token, :created_at, :updated_at, :type

  belongs_to :public_agency
  belongs_to :public_office
end
