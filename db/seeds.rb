require 'csv'

CSV.foreach(Rails.root.join('lib', 'seeds', 'weapons.CSV'), headers: true, col_sep: ';', encoding: 'ISO-8859-1') do |row|
  Weapon.create!(
    name: row['name'],
    price: row['price'],
    size: row['size'],
    ammo_slots: row['ammo_slots'],
    kind: row['kind'],
    bloodline_rank: row['bloodline_rank']
  )
end
puts "Seeded weapons."

CSV.foreach(Rails.root.join('lib', 'seeds', 'tools.CSV'), headers: true, col_sep: ';', encoding: 'ISO-8859-1') do |row|
  Tool.create!(
    name: row['name'],
    price: row['price'],
    kind: row['kind'],
    bloodline_rank: row['bloodline_rank']
  )
end
puts "Seeded tools."

CSV.foreach(Rails.root.join('lib', 'seeds', 'consumables.CSV'), headers: true, col_sep: ';', encoding: 'ISO-8859-1') do |row|
  Consumable.create!(
    name: row['name'],
    price: row['price'],
    kind: row['kind'],
    bloodline_rank: row['bloodline_rank']
  )
end
puts "Seeded consumables."
