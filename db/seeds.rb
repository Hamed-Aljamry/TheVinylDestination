# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

puts "Cleaning up database....."

Vinyl.destroy_all
User.destroy_all

puts "Database cleaned 🧼"

users = []
10.times do |n|
  users << User.create!(
    email: "user#{n + 1}@example.com",
    nickname: Faker::Name.first_name,
    password: "password"
  )
end
puts "Users created"
puts "Creating Vinyls....."

images = ["app/assets/images/TylerVinyl.jpeg", "app/assets/images/DrakeVinyl.webp", "app/assets/images/WeekndVinyl.jpeg", "app/assets/images/DirtyComputerVinyl.jpg","app/assets/images/PinkFloydVinyl.avif", "app/assets/images/MichealJacksonVinyl.webp", "app/assets/images/KidCudiVinyl.jpeg", "app/assets/images/KendrickVinylCover.jpeg", "app/assets/images/KanyeVinyl.jpeg", "app/assets/images/FrankOceanVinyl.jpeg"]

10.times do
  file = URI.open(images.sample)
  vinyl = Vinyl.create!(
    name: Faker::Music.album,
    description: Faker::Lorem.paragraph,
    price: rand(10..50),
    artist: Faker::Music.band,
    genre: Faker::Music.genre,
    released_at: Faker::Date.between(from: 30.years.ago, to: Date.today),
    music_url: "https://example.com/music/#{rand(1..100)}.mp3",
    user: users.sample
  )
  vinyl.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  vinyl.save
end


puts "seeds created"
