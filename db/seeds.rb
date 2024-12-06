# This file ensures the existence of required records to run the application
# in every environment (production, development, test).
# The code here is idempotent and can be executed at any point in every environment.
# Load data with bin/rails db:seed or db:setup

# Cleaning the database in development
if Rails.env.development?
  puts "Cleaning database..."
  Property.destroy_all
  User.destroy_all
end

require 'faker'
require 'open-uri'

puts 'Creating users...'
user = User.first || User.create!(
  email: 'admin@cemy.com',
  password: 'admin@cemy.com'
)

PROPERTY_IMAGES = [
  'https://images.unsplash.com/photo-1560185009-dddeb820c7b7',
  'https://images.unsplash.com/photo-1501876725168-00c445821c9e',
  'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
  'https://images.unsplash.com/photo-1567684014761-b65e2e59b9eb',
  'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
  'https://images.unsplash.com/photo-1460408037948-b89a5e837b41',
  'https://images.unsplash.com/photo-1531835551805-16d864c8d311',
  'https://images.unsplash.com/photo-1616046229478-9901c5536a45',
  'https://images.unsplash.com/photo-1486304873000-235643847519',
  'https://images.unsplash.com/photo-1529408686214-b48b8532f72c',
  'https://images.unsplash.com/photo-1497898871738-28f5fb9b275c'
]

puts 'Creating 10 fake properties...'
10.times do |index|
  # Create a new property
  property = Property.new(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    price_per_night: rand(50..500),
    rating: rand(1..5),
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    user: user
  )

  # Download and attach the image
  begin
    # Download the image from the URL
    downloaded_image = URI.open(PROPERTY_IMAGES[index % PROPERTY_IMAGES.length])

    # Attach the image to the property
    property.image.attach(
      io: downloaded_image,
      filename: "property_#{index}.jpg",
      content_type: 'image/jpeg'
    )
  rescue OpenURI::HTTPError => e
    puts "Could not download image for property #{index}: #{e.message}"
    # Optionally, you could use a placeholder or skip image attachment
  end

  # Save the property
  property.save!
end

puts "Finished! Created #{Property.count} properties."
p Property.all