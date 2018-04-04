class AddCityToNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    add_reference :neighborhoods, :city, foreign_key: true
  end
end
