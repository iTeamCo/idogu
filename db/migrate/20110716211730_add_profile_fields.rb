class AddProfileFields < ActiveRecord::Migration
  def change
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
    add_column :profiles, :gender, :boolean
    add_column :profiles, :birthday, :date
    add_column :profiles, :email, :string
  end
end
