class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, :end_date, :number_of_guests, presence: true
  validate :start_date_before_end_date

  private

  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:start_date, "must be before check-out date")
    end
  end
end
