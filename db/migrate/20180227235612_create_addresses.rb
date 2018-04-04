class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.integer :number, null: false
      t.string :cep

      t.timestamps
    end
  end
end
