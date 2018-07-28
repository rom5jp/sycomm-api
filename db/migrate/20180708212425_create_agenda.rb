class CreateAgenda < ActiveRecord::Migration[5.1]
  def change
    create_table :agendas do |t|
      t.string :name
      t.date :start_date, null: false, default: Date.current
      t.timestamps

      t.belongs_to :employee, index: true
    end
  end
end
