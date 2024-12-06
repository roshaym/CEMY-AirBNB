class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  # No validation for now
  # validates :check_in, :check_out, :guests, presence: true
  # validate :check_out_after_check_in  # You can also remove this for now
end
