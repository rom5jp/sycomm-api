class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :registration, unique: true, null: false
      t.string :email, unique: true, null: false
      t.string :name, null: false
      t.string :nickname
      t.string :cpf, unique: true, null: false
      t.string :landline
      t.string :cellphone
      t.string :whatsapp
      t.string :simple_address, null: false
      t.string :type

      t.index :registration
      t.index :cpf
      t.index :email

      t.timestamps
    end
  end
end
