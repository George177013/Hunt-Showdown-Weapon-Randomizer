# Clear old data
Ammo.destroy_all
Weapon.destroy_all
Consumable.destroy_all
Tool.destroy_all

weapons = Weapon.create!([
  { name: "Romero 77", price: 34, size: 3, ammo_slots: 2, kind: "Shotgun", bloodline_rank: 15 },
  { name: "Caldwell Conversion Pistol", price: 26, size: 1, ammo_slots: 1, kind: "Pistol", bloodline_rank: 5 },
  { name: "Winfield M1873", price: 94, size: 3, ammo_slots: 1, kind: "Rifle", bloodline_rank: 20 },
  { name: "Sparks LRR", price: 130, size: 3, ammo_slots: 2, kind: "Rifle", bloodline_rank: 25 },
  { name: "Caldwell Pax", price: 26, size: 1, ammo_slots: 1, kind: "Pistol", bloodline_rank: 10 },
  { name: "Caldwell Pax Duallies", price: 26, size: 2, ammo_slots: 1, kind: "Pistol", bloodline_rank: 12 }
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
  { name: "Vitality Shot", price: 15, kind: "Healing", bloodline_rank: 8 },
  { name: "Weak Vitality Shot", price: 5, kind: "Healing", bloodline_rank: 3 },
  { name: "Antidote Shot", price: 20, kind: "Buff", bloodline_rank: 12 },
  { name: "Sticky Bomb", price: 30, kind: "Explosive", bloodline_rank: 15 },
  { name: "Ammo Box", price: 35, kind: "Utility", bloodline_rank: 10 },
  { name: "Poison Bomb", price: 25, kind: "Explosive", bloodline_rank: 14 },
  { name: "Flash Bomb", price: 15, kind: "Explosive", bloodline_rank: 7 },
  { name: "Flares", price: 10, kind: "Utility", bloodline_rank: 4 },
  { name: "Tonic", price: 10, kind: "Buff", bloodline_rank: 6 },
  { name: "Bandage", price: 5, kind: "Healing", bloodline_rank: 2 },
  { name: "Bait", price: 12, kind: "Utility", bloodline_rank: 5 },
  { name: "Melee Trap", price: 15, kind: "Trap", bloodline_rank: 9 }
])

Tool.create!([
  { name: "First Aid Kit", price: 20, kind: "Healing", bloodline_rank: 5 },
  { name: "Choke Bomb", price: 10, kind: "Utility", bloodline_rank: 6 },
  { name: "Concertina Bomb", price: 25, kind: "Trap", bloodline_rank: 10 },
  { name: "Knife", price: 15, kind: "Melee", bloodline_rank: 1 },
  { name: "Sledgehammer", price: 25, kind: "Melee", bloodline_rank: 12 },
  { name: "Bear Trap", price: 35, kind: "Trap", bloodline_rank: 11 },
  { name: "Explosive Barrel", price: 40, kind: "Explosive", bloodline_rank: 15 },
  { name: "Pistol", price: 35, kind: "Melee", bloodline_rank: 8 },
  { name: "Throwing Axes", price: 20, kind: "Melee", bloodline_rank: 9 },
  { name: "Flashbang", price: 18, kind: "Utility", bloodline_rank: 7 },
  { name: "Crowbar", price: 12, kind: "Melee", bloodline_rank: 2 },
  { name: "Dynamite", price: 45, kind: "Explosive", bloodline_rank: 16 },
  { name: "Healing Salve", price: 15, kind: "Healing", bloodline_rank: 4 }
])
