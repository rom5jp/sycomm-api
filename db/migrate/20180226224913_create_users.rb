class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :telefone
      t.string :whatsapp
      t.string :cpf
      t.string :type

      t.timestamps
    end
  end
end
