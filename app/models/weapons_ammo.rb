class WeaponsAmmo < ApplicationRecord
  belongs_to :weapon
  belongs_to :ammo
end
