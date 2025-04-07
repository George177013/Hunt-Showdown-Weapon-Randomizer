class Loadout
  attr_reader :primary_weapon, :secondary_weapon, :ammos, :consumables, :tools

  # TODO: No duallies
  # TODO: Froce medkit and melee

  def initialize
    @primary_weapon = { name: "", price: 0 }
    @secondary_weapon = { name: "", price: 0 }
    @ammos = { ammo_primary: [], ammo_secondary: [] }
    @consumables = []
    @tools = []
    @total_cost = 0
  end

  def randomize
    config = {
      slots: 5,
      budget: 10000,
      bloodline_rank: 100,
      tools_count: 4,
      consumables_count: 4,
      intelligent: true
    }

    max_attempts = 32
    attempts = 0

    begin
      @primary_weapon = { name: "", price: 0 }
      @secondary_weapon = { name: "", price: 0 }
      @ammos = { ammo_primary: [], ammo_secondary: [] }
      @consumables = []
      @tools = []
      @total_cost = 0

      attempts += 1

      if config[:intelligent]
        kind_categories = {
          long: [ "rifle" ],
          mid: [ "pistol" ],
          short: [ "shotgun", "pistol_dual", "special" ]
        }

        @primary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where("size >= 2").order("RANDOM()").first

        slots_left = config[:slots] - @primary_weapon.size

        pw_category = kind_categories.find { |k, arr| arr.include?(@primary_weapon.kind) }&.first

        kinds_left = kind_categories.reject { |key, _| key == pw_category }.values.flatten

        @secondary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where(kind: kinds_left).where(size: slots_left).order("RANDOM()").first
      else
        @primary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where("size >= 2").order("RANDOM()").first
        slots_left = config[:slots] - @primary_weapon.size
        @secondary_weapon = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank]).where(size: slots_left).order("RANDOM()").first
      end

      if @primary_weapon.ammos.where(pool: 2).exists?
        @ammos[:ammo_primary] << @primary_weapon.ammos.where(pool: 1).order("RANDOM()").first
        @ammos[:ammo_primary] << @primary_weapon.ammos.where(pool: 2).order("RANDOM()").first
      else
        @primary_weapon.ammo_slots.times do
          @ammos[:ammo_primary] << @primary_weapon.ammos.order("RANDOM()").first
        end
      end

      if @secondary_weapon.ammos.where(pool: 2).exists?
        @ammos[:ammo_secondary] << @secondary_weapon.ammos.where(pool: 1).order("RANDOM()").first
        @ammos[:ammo_secondary] << @secondary_weapon.ammos.where(pool: 2).order("RANDOM()").first
      else
        @secondary_weapon.ammo_slots.times do
          @ammos[:ammo_secondary] << @secondary_weapon.ammos.order("RANDOM()").first
        end
      end

      @tools = Tool.where("bloodline_rank <= ?", config[:bloodline_rank]).order("RANDOM()").first(config[:tools_count])

      config[:consumables_count].times do
        @consumables << Consumable.where("bloodline_rank <= ?", config[:bloodline_rank]).order("RANDOM()").first
      end

      @total_cost = @primary_weapon.price + @secondary_weapon.price + @ammos[:ammo_primary].sum(&:price) + @ammos[:ammo_secondary].sum(&:price) + @consumables.sum(&:price) + @tools.sum(&:price)

    end while @total_cost > config[:budget] && attempts < max_attempts
  end

  def show
    puts "Primary Weapon: #{@primary_weapon.name} - Price: #{@primary_weapon.price}"

    puts "Primary Ammo:"
    @ammos[:ammo_primary].each_with_index do |ammo, index|
      puts "  #{index + 1}. #{ammo.name} - Price: #{ammo.price}"
    end

    puts "Secondary Weapon: #{@secondary_weapon.name} - Price: #{@secondary_weapon.price}"

    puts "Secondary Ammo:"
    @ammos[:ammo_secondary].each_with_index do |ammo, index|
      puts "  #{index + 1}. #{ammo.name} - Price: #{ammo.price}"
    end

    puts "Tools:"
    @tools.each_with_index do |tool, index|
      puts "  #{index + 1}. #{tool.name} - Price: #{tool.price}"
    end

    puts "Consumables:"
    @consumables.each_with_index do |consumable, index|
      puts "  #{index + 1}. #{consumable.name} - Price: #{consumable.price}"
    end

    puts "Total Cost: #{@total_cost}"
  end
end
