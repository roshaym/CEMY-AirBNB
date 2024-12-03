# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# TYPE = ["Chinese", "Italian", "Japanese", "French", "Belgian"]

puts "Cleaning database..."
Property.destroy_all if Rails.env.development?

require 'faker'

puts 'Creating 10 fake properties...'
10.times do
  property = Property.new(
    name:    Faker::Company.name,
    rating: rand(0..5),
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}"
  )
  property.save!
end
puts "Finished! Created #{Property.count} properties."
p Property.all
