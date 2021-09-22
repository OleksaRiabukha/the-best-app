class CreateGeocodedAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :geocoded_addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :street
      t.string :building



      t.timestamps
    end
  end
end
