class DefaultValueForBloodlinRank < ActiveRecord::Migration[8.0]
  def change
    change_column_default :weapons, :bloodline_rank, 1
    change_column_default :tools, :bloodline_rank, 1
    change_column_default :consumables, :bloodline_rank, 1
  end
end
