class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :initials, null: false

      t.timestamps
    end
  end
end
