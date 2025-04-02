class Ammo < ApplicationRecord
  has_many :weapons_ammos
  has_many :weapons, through: :weapons_ammos
end
