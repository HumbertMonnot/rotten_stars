# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

address_list = %w(merignac pessac talence bordeaux begles cenon lormont eysines gradignan canéjan bouliac tresses yvrac latresne léognan cestas cadaujac)

puts "suppression des Reviews"
Review.destroy_all
puts "suppression des Reservations"
Reservation.destroy_all
puts "suppression des prestations"
Prestation.destroy_all
puts "suppression des users"
User.destroy_all

puts "creation of users"

10.times do
  User.create(
    email: Faker::Internet.email,
    password: "secret",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::Number.leading_zero_number(digits: 10)
  )
end

puts "Taking avatars"

User.all.each do |user|
  file = URI.open('https://i.pravatar.cc/100')
  user.avatar.attach(io: file, filename: "#{user.first_name}_#{user.last_name}.png", content_type: 'image/png')
end

puts "creation of prestations"

20.times do
  name = Faker::Artist.name
  category = ["sing", "danse"].sample
  description = Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false)
  price = (50..3000).to_a.sample
  address = address_list.sample
  punchline = Faker::Lorem.sentence(word_count: 3)
  user = User.all.sample
  presta = Prestation.new(
    name: name,
    category: category,
    description: description,
    price: price,
    address: address,
    distance: (30...60).to_a.sample,
    punchline: punchline,
  )
  presta.user = user
  presta.save
end

puts "Taking posters"

dico = {
  "danse" => "dancer",
  "sing" => "singer"
}

Prestation.all.each do |prestation|
  file = URI.open(Faker::LoremFlickr.image(size: "200x200", search_terms: [dico[prestation.category]]))
  prestation.poster.attach(io: file, filename: "#{prestation.name}.png", content_type: 'image/png')
end

puts "creation of reservations"

40.times do
  year = ['2011', '2012', '2013', '2014', '2015', '2016', '2017'].sample
  month = (1..11).to_a.sample
  day = (1..20).to_a.sample
  duration = (1..10).to_a.sample
  presta = Prestation.all.sample
  user = User.all.sample
  resa = Reservation.create(
    start_date: "#{year}-#{month}-#{day}",
    end_date: "#{year}-#{month}-#{day + duration}",
    price: presta.price,
    total: presta.price * duration,
    state: ["pending", "accepted", "rejected"].sample,
  )
  resa.user = user
  resa.prestation = presta
  resa.save
end

puts "creation of reviews"

nb_review = Reservation.where(state: "accepted").count
p nb_review

nb_review.times do
  resa = Reservation.all.select { |resa| resa.state = "accepted"}.sample
  user = resa.user
  review = Review.new(
    rating: (1..5).to_a.sample,
    comment: Faker::Lorem.sentence(word_count: (3..6).to_a.sample),
  )
  review.user = [resa.user, resa.prestation.user].sample
  review.save
end
