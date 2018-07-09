class CreateAgenda < ActiveRecord::Migration[5.1]
  def change
    create_table :agendas do |t|
      t.string :name
      t.datetime :start_date
      t.timestamps

      t.belongs_to :user, index: true
    end
  end
end
