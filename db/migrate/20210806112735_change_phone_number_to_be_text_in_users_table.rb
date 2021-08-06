class ChangePhoneNumberToBeTextInUsersTable < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :phone_number, :text
  end
end
