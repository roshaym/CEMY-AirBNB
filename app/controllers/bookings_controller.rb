class BookingsController < ApplicationController
  before_action :set_property

  def new
    @booking = @property.bookings.build
  end

  def create
    @booking = @property.bookings.build(booking_params)
    @booking.user = current_user # Assign the logged-in user to the booking

    if @booking.save
      redirect_to @property, notice: 'Booking created successfully.'
    else
      render :new
    end
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :number_of_guests)
  end
end
