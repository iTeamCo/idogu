class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.integer :user_id
      t.string :message

      t.timestamps
    end
  end
end
