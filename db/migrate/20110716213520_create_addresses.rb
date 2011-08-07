class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country, limit: 2
      t.string :zip_code
      t.string :city
      t.text :address
      t.references :addressable, :polymorphic => true
      t.timestamps
    end
  end
end
