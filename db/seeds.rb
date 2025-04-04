# Clear old data
Ammo.destroy_all
Weapon.destroy_all
Consumable.destroy_all
Tool.destroy_all

weapons = Weapon.create!([
  { name: "Romero 77", price: 34, size: 3, ammo_slots: 2, kind: "Shotgun" },
  { name: "Caldwell Conversion Pistol", price: 26, size: 1, ammo_slots: 1, kind: "Pistol" },
  { name: "Winfield M1873", price: 94, size: 3, ammo_slots: 1, kind: "Rifle" },
  { name: "Sparks LRR", price: 130, size: 3, ammo_slots: 2, kind: "Rifle" },
  { name: "Caldwell Pax", price: 26, size: 1, ammo_slots: 1, kind: "Pistol" },
  { name: "Caldwell Pax Duallies", price: 26, size: 2, ammo_slots: 1, kind: "Pistol" }
])

Ammo.create!([
  { name: "Buckshot", price: 5, weapon: weapons[0] },
  { name: "Dragon Breath", price: 8, weapon: weapons[0] },

  { name: "DumDum", price: 2, weapon: weapons[1] },
  { name: "Poison", price: 4, weapon: weapons[1] },

  { name: "Poison", price: 6, weapon: weapons[2] },
  { name: "Incendiary", price: 7, weapon: weapons[2] },

  { name: "Long Ammo", price: 10, weapon: weapons[3] },
  { name: "Poison", price: 14, weapon: weapons[3] },

  { name: "DumDum", price: 2, weapon: weapons[4] },
  { name: "Poison", price: 4, weapon: weapons[4] },

  { name: "DumDum", price: 2, weapon: weapons[5] },
  { name: "Poison", price: 4, weapon: weapons[5] }
])

Consumable.create!([
  { name: "Vitality Shot", price: 15, kind: "Healing" },
  { name: "Weak Vitality Shot", price: 5, kind: "Healing" },
  { name: "Antidote Shot", price: 20, kind: "Buff" },
  { name: "Sticky Bomb", price: 30, kind: "Explosive" }
])

Tool.create!([
  { name: "First Aid Kit", price: 20, kind: "Healing" },
  { name: "Choke Bomb", price: 10, kind: "Utility" },
  { name: "Concertina Bomb", price: 25, kind: "Trap" },
  { name: "Knife", price: 15, kind: "Melee" }
])
