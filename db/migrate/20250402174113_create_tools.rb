class CreateTools < ActiveRecord::Migration[8.0]
  def change
    create_table :tools do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :type

      t.timestamps
    end
  end
end
