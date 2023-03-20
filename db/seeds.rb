# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning up database....."

Vinyl.destroy_all
User.destroy_all

puts "Database cleaned 🧼"

users = []
10.times do |n|
  users << User.create!(
    email: "user#{n + 1}@example.com",
    password: "password"
  )
end
puts "Users created"
puts "Creating Vinyls....."
vinyls = []
10.times do |n|
  vinyls << Vinyl.create!(
    name: "Vinyl #{n + 1}",
    description: "This is Vinyl #{n + 1}",
    price: rand(10..50),
    artist: "Artist #{n + 1}",
    genre: "Genre #{n + 1}",
    released_at: Date.today - rand(1..10).years,
    music_url: "https://example.com/music/#{n+1}.mp3",
    user: users[n]
  )
end

puts "seeds created"
