class RemoveUserFields < ActiveRecord::Migration
  def up
    remove_column :users, :password_hash
    remove_column :users, :password_salt
    remove_column :users, :user_name
  end

  def down
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    add_column :users, :user_name, :string
  end
end
