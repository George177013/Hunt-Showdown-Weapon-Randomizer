class CreateConsumables < ActiveRecord::Migration[8.0]
  def change
    create_table :consumables do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :type

      t.timestamps
    end
  end
end
