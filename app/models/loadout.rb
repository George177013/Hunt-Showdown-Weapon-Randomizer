class Loadout
  attr_reader :primary_weapon, :secondary_weapon, :ammos, :consumables, :tools

  def initialize
    @primary_weapon = { name: "", price: 0 }
    @secondary_weapon = { name: "", price: 0 }
    @ammos = { ammo_primary: [], ammo_secondary: [] }
    @consumables = []
    @tools = []
  end

  def randomize(budget, slots)
    @primary_weapon = Weapon.order("RANDOM()").where("size >=2").first
    slots_left = slots - @primary_weapon.size
    @secondary_weapon = Weapon.order("RANDOM()").where(size: slots_left).first

    ammo_slots1 = @primary_weapon.ammo_slots
    ammo_slots2 = @secondary_weapon.ammo_slots

    ammo_slots1.times do
      @ammos[:ammo_primary] << @primary_weapon.ammos.order("RANDOM()").first
    end

    ammo_slots2.times do
      @ammos[:ammo_secondary] << @secondary_weapon.ammos.order("RANDOM()").first
    end

    @consumables = Consumable.order("RANDOM()").first(4)

    @tools = Tool.order("RANDOM()").first(4)
  end
end
