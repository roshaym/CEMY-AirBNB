class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :check_in, :check_out, :number_of_guests, presence: true
  validate :check_in_before_check_out

  private

  def check_in_before_check_out
    if check_in.present? && check_out.present? && check_in >= check_out
      errors.add(:check_in, "must be before check-out date")
    end
  end
end
