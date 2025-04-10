class Loadout
  attr_reader :primary_weapon, :secondary_weapon, :ammos, :consumables, :tools, :total_cost

  def initialize
    @primary_weapon = { name: "", price: 0 }
    @secondary_weapon = { name: "", price: 0 }
    @ammos = { ammo_primary: [], ammo_secondary: [] }
    @consumables = []
    @tools = []
    @total_cost = 0
  end

  def randomize(config)
    ActiveRecord::Base.uncached do
      # config = {
      #   slots: 4,
      #   budget: 10000,
      #   bloodline_rank: 100,
      #   tools_count: 4,
      #   consumables_count: 4,
      #   intelligent: true,
      #   dualies: true,
      #   force_medkit: true,
      #   force_melee: true
      # }

      max_attempts = 64
      attempts = 0

      begin
        @primary_weapon = { name: "", price: 0 }
        @secondary_weapon = { name: "", price: 0 }
        @ammos = { ammo_primary: [], ammo_secondary: [] }
        @consumables = []
        @tools = []
        @total_cost = 0

        attempts += 1

        weapon_scope = Weapon.where("bloodline_rank <= ?", config[:bloodline_rank])
        weapon_scope = weapon_scope.where.not(kind: "pistol_dual") unless config[:dualies]

        if config[:intelligent]
          kind_categories = {
            long: [ "rifle" ],
            mid: [ "pistol" ],
            short: [ "shotgun", "special", "pistol_dual", "melee" ]
          }

          @primary_weapon = weapon_scope.where("size >= 2").order("RANDOM()").first
          slots_left = config[:slots] - @primary_weapon.size

          pw_category = kind_categories.find { |k, arr| arr.include?(@primary_weapon.kind) }&.first
          kinds_left = kind_categories.reject { |key, _| key == pw_category }.values.flatten

          @secondary_weapon = weapon_scope.where(kind: kinds_left, size: slots_left).order("RANDOM()").first
        else
          @primary_weapon = weapon_scope.where("size >= 2").order("RANDOM()").first
          slots_left = config[:slots] - @primary_weapon.size
          @secondary_weapon = weapon_scope.where(size: slots_left).order("RANDOM()").first
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

        if config[:force_medkit] && !@tools.any? { |tool| tool.name == "First Aid Kit" }
          @tools[0] = Tool.where(name: "First Aid Kit").first
        end

        if config[:force_melee] && !@tools.any? { |tool| tool.kind == "melee" } && @secondary_weapon.kind != "melee"
          @tools[1] = Tool.where("bloodline_rank <= ?", config[:bloodline_rank]).where(kind: "melee").order("RANDOM()").first
        end

        config[:consumables_count].times do
          @consumables << Consumable.where("bloodline_rank <= ?", config[:bloodline_rank]).order("RANDOM()").first
        end

        @total_cost = @primary_weapon.price + @secondary_weapon.price + @ammos[:ammo_primary].sum(&:price) + @ammos[:ammo_secondary].sum(&:price) + @consumables.sum(&:price) + @tools.sum(&:price)

      end while @total_cost > config[:budget] && attempts < max_attempts
    end
  end
end
