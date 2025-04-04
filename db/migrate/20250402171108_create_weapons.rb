class CreateWeapons < ActiveRecord::Migration[8.0]
  def change
    create_table :weapons do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :size, null: false
      t.integer :ammo_slots, null: false
      t.string :type

      t.timestamps
    end
  end
end
