class RenameTypeColumn < ActiveRecord::Migration[8.0]
  def change
    rename_column :weapons, :type, :kind
    rename_column :tools, :type, :kind
    rename_column :consumables, :type, :kind
  end
end
