class CreateCategoriesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.text :description

      t.timestamps
    end
  end
end
