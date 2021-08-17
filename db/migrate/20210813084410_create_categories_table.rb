class CreateCategoriesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.text :description

      t.index :name, unique: true
      t.timestamps
    end
  end
end
