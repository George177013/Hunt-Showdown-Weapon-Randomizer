class MakeAllColumnsNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :ammos, :name, false
    change_column_null :ammos, :price, false

    change_column_null :consumables, :name, false
    change_column_null :consumables, :price, false
    change_column_null :consumables, :type, false

    change_column_null :tools, :name, false
    change_column_null :tools, :price, false
    change_column_null :tools, :type, false

    change_column_null :weapons, :name, false
    change_column_null :weapons, :price, false
    change_column_null :weapons, :slot, false
    change_column_null :weapons, :type, false
  end
end
