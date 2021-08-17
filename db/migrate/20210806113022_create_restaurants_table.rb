class CreateRestaurantsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, default: ''
      t.string :phone_number
      t.string :website_url
      t.text :description
      t.boolean :active, null: false, default: false

      t.index :name, unique: true
      t.timestamps
    end
  end
end
