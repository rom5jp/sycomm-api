class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :registration, unique: true
      t.string :email
      t.string :name, null: false
      t.string :surname
      t.string :nickname
      t.string :cpf
      t.string :landline
      t.string :cellphone
      t.string :whatsapp
      t.string :simple_address
      t.string :type, null: false

      t.index :registration
      t.index :cpf
      t.index :email

      t.timestamps null: false
    end
  end
end
