require "open-uri"
require "json"

Pokeball.destroy_all
Trainer.destroy_all
Pokemon.destroy_all

puts 'Creating trainers...'
ash = Trainer.create(name: "Ash Ketchum", age: 18)
ash.photo.attach(
  io: URI.parse("https://upload.wikimedia.org/wikipedia/en/e/e4/Ash_Ketchum_Journeys.png").open,
  filename: "ash_ketchum.png",
  content_type: "image/png"
)
puts "Ash has stepped up to the plate!"

misty = Trainer.create(name: "Misty", age: 20)
misty.photo.attach(
  io: URI.parse('https://upload.wikimedia.org/wikipedia/en/b/b1/MistyEP.png').open,
  filename: 'misty.png',
  content_type: 'image/png'
)
puts "Misty is ready to go!"

brock = Trainer.create(name: "Brock", age: 22)
brock.photo.attach(
  io: URI.parse('https://upload.wikimedia.org/wikipedia/en/7/71/DP-Brock.png').open,
  filename: 'brock.png',
  content_type: 'image/png'
)
puts "Brock is on the scene!"


puts 'Creating pokemons...'

response = URI.parse('https://pokeapi.co/api/v2/pokemon?limit=50').open.read
results = JSON.parse(response)["results"]

results.each do |result|
  pokemon_data = JSON.parse(URI.parse(result["url"]).open.read)
  name = pokemon_data["name"]
  element_type = pokemon_data["types"].first["type"]["name"]
  image_url = pokemon_data["sprites"]["front_shiny"]

  pokemon = Pokemon.create(name: name, element_type: element_type)
  pokemon.photo.attach(
    io: URI.parse(image_url).open,
    filename: "#{pokemon.name}.png",
    content_type: "image/png"
  )
  puts "Screeahhhhh! #{pokemon.name} created!"
end

puts "Creating pokeballs..."
towns = ["Vermilion City", "Cerulean City", "Pewter City", "Saffron City", "Celadon City", "Cinnabar Island", "Fuchsia City"]

Trainer.all.each do |trainer|
  Pokemon.all.sample(3).each do |pokemon|
    Pokeball.create(
      location: towns.sample,
      caught_on: Time.now,
      trainer: trainer,
      pokemon: pokemon
    )
    puts "Pokeball created for #{trainer.name} with #{pokemon.name}!"
  end
end

puts "Finished! Created #{Trainer.count} trainers, #{Pokemon.count} pokemons, and #{Pokeball.count} pokeballs."