class AddPublicAgencyAndPublicOfficeAndAddressToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :public_agency, foreign_key: true
    add_reference :users, :public_office, foreign_key: true
    add_reference :users, :address, foreign_key: true
  end
end
