class Weapon < ApplicationRecord
  has_many :weapons_ammos
  has_many :ammos, through: :weapons_ammos

  validates :slot, inclusion: { in: [ 0, 1, 2 ] }
end
