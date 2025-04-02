class CreateConsumables < ActiveRecord::Migration[8.0]
  def change
    create_table :consumables do |t|
      t.string :name
      t.integer :price
      t.string :type

      t.timestamps
    end
  end
end
