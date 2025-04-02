class CreateWeaponsAmmos < ActiveRecord::Migration[8.0]
  def change
    create_table :weapons_ammos do |t|
      t.references :weapon, null: false, foreign_key: true
      t.references :ammo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
