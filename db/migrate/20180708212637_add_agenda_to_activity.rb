class AddAgendaToActivity < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :agenda, foreign_key: true
  end
end
