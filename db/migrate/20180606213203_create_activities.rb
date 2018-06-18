class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string      :name
      t.string      :description
      t.integer     :status, null: false, default: 0
      t.integer     :type
      t.integer     :client_id
      t.string      :client_name
      t.belongs_to  :user, index: true

      t.timestamps
    end
  end
end
