class AddNeighborhoodAndCityAndStateToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :neighborhood, foreign_key: true
    add_reference :addresses, :city, foreign_key: true
    add_reference :addresses, :state, foreign_key: true
  end
end
