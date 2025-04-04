class AddBloodlineRank < ActiveRecord::Migration[8.0]
  def change
    add_column :weapons, :bloodline_rank, :integer, null: false
    add_column :consumables, :bloodline_rank, :integer, null: false
    add_column :tools, :bloodline_rank, :integer, null: false
  end
end
