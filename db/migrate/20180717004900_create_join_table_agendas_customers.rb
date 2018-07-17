class CreateJoinTableAgendasCustomers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :agendas, :customers do |t|
      t.index [:agenda_id, :customer_id]
      t.index [:customer_id, :agenda_id]
    end
  end
end
