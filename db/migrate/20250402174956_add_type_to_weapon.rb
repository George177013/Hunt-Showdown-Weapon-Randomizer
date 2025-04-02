class AddTypeToWeapon < ActiveRecord::Migration[8.0]
  def change
    add_column :weapons, :type, :string, null: false
  end
end
