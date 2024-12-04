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

# This file ensures the existence of required records to run the application in every environment (production, development, test).
# The code here is idempotent so that it can be executed at any point in every environment.
# The data can be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Cleaning the database
puts "Cleaning database..."
Property.destroy_all if Rails.env.development?
User.destroy_all if Rails.env.development?

require 'faker'

# Ensure at least one user exists
puts 'Creating users...'
user = User.first || User.create!(email: 'example@example.com', password: 'password123')

puts 'Creating 10 fake properties...'
10.times do
  property = Property.new(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    rating: rand(1..5),
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    user: user # Pass the actual User instance
  )
  property.save!
end

puts "Finished! Created #{Property.count} properties."
p Property.all
