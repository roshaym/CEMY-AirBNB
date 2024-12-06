class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :additional_images
  has_one_attached :main_image
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :description, :price_per_night, :rating, :image_url, :address, presence: true
end
