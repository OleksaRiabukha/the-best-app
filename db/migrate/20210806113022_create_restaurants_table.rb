class CreateRestaurantsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, default: ""
      t.text :phone_number
      t.string :website_url
      t.text :description
      t.boolean :hidden, null: false, default: true

      t.timestamps
    end
  end
end
