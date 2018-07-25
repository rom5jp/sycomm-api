class ActivitySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :annotations,
             :status,
             :activity_type,
             :customer_id,
             :customer_name,
             :employee_id,
             :created_at,
             :updated_at

  # belongs_to :agenda
  # belongs_to :employee
end
