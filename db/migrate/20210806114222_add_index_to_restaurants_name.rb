class AddIndexToRestaurantsName < ActiveRecord::Migration[6.1]
  def change
    add_index :restaurants, :name, unique: true
  end
end
