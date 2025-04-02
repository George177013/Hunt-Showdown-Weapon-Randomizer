class RemoveAmmo < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :weapons, :ammos
    remove_column :weapons, :ammo_id
  end
end
