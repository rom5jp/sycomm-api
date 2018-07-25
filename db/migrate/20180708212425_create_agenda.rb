class CreateAgenda < ActiveRecord::Migration[5.1]
  def change
    create_table :agendas do |t|
      t.string :name
      t.datetime :start_date, null: false, default: Time.now
      t.timestamps

      t.belongs_to :employee, index: true
    end
  end
end
