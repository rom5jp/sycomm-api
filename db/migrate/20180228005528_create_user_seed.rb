class CreateUserSeed < ActiveRecord::Migration[5.1]
  def change
    create_table :user_seeds do |t|
      t.string :name
      t.string :registration
      t.string :organization
      t.string :role
      t.string :cpf
      t.string :simple_address
    end
  end
end
