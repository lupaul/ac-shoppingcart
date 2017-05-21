class AddAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, index: true
  end
end
