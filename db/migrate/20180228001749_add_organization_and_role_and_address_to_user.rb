class AddOrganizationAndRoleAndAddressToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :organization, foreign_key: true
    add_reference :users, :role, foreign_key: true
    add_reference :users, :address, foreign_key: true
  end
end
