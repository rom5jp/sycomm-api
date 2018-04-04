class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :registration, unique: true
      t.string :email, unique: true, null: false, default: ""
      t.string :name, null: false
      t.string :surname
      t.string :nickname
      t.string :cpf, unique: true, null: false
      t.string :landline
      t.string :cellphone, null: false, default: ""
      t.string :whatsapp
      t.string :simple_address
      t.string :type, null: false

      t.index :registration
      t.index :cpf
      t.index :email

      t.timestamps
    end
  end
end
