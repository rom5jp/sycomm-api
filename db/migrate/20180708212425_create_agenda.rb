class CreateAgenda < ActiveRecord::Migration[5.1]
  def change
    create_table :agendas do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.timestamps

      t.belongs_to :employee, index: true
    end
  end
end
