class CreateAmmos < ActiveRecord::Migration[8.0]
  def change
    create_table :ammos do |t|
      t.string :name
      t.integer :price
      t.references :weapon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
