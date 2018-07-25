class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string      :name
      t.string      :description
      t.string      :annotations
      t.integer     :status, null: false, default: 0
      t.integer     :activity_type
      t.integer     :customer_id
      t.string      :customer_name
      t.belongs_to  :employee, index: true

      t.timestamps
    end
  end
end
