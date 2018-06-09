class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.integer :status, null: false, default: 0
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
