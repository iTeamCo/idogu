class ChangeProfileEmailToAlternativeEmail < ActiveRecord::Migration
  def change
    rename_column :profiles, :email, :alternative_email
  end
end
