class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :description, :price_per_night, :rating, :image_url, :address, presence: true
end
