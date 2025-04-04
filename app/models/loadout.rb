class Loadout
  attr_reader :primary_weapon, :secondary_weapon, :ammos, :consumables, :tools

  def initialize
    @primary_weapon = { name: "", price: 0 }
    @secondary_weapon = { name: "", price: 0 }
    @ammos = { ammo_primary: [], ammo_secondary: [] }
    @consumables = []
    @tools = []
    @total_cost
  end

  def randomize
    config = {
      slots: 4,
      budget: 100,
      bloodline_rank: 100,
      tools_count: 4,
      consumables_count: 4
    }

    max_attempts = 32
    attempts = 0

    begin
      attempts += 1

      @primary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where("size >= 2").order("RANDOM()").first
      slots_left = config[:slots] - @primary_weapon.size
      @secondary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where(size: slots_left).order("RANDOM()").first

      @ammos[:ammo_primary] << @primary_weapon.ammos.order("RANDOM()").first(@primary_weapon.ammo_slots)

      @ammos[:ammo_secondary] << @secondary_weapon.ammos.order("RANDOM()").first(@secondary_weapon.ammo_slots)

      @consumables = Consumable.where("bloodline_rank <= ?", config[:bloodline_rank]).order("RANDOM()").first(config[:consumables_count])

      @tools = Tool.where("bloodline_rank <= ?", config[:bloodline_rank]).order("RANDOM()").first(config[:tools_count])

      @total_cost = @primary_weapon.price + @secondary_weapon.price + @ammos[:ammo_primary].sum(&:price) + @ammos[:ammo_secondary].sum(&:price) + @consumables.sum(&:price) + @tools.sum(&:price)

    end while @total_cost > config[:budget] && attempts < max_attempts
  end
end
