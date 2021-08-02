class AddRoleToUser < ActiveRecord::Migration[6.1]
  enable_extension "plpgsql"
   
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('simple', 'admin');
    SQL
    add_column :users, :role, :user_role, default: "simple"
    add_index :users, :role
  end

  def down
    remove_column :users, :role
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
