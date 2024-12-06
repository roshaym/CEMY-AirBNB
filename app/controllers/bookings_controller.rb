class BookingsController < ApplicationController
  before_action :set_property

  def new
    @booking = @property.bookings.build
  end

def create
    @booking = @property.bookings.new(booking_params)
    @booking.user = current_user  # Associate the current user with the booking

    # Save booking without validation for now (force success)
    if @booking.save
      flash[:notice] = 'Hooray! Your booking is confirmed!' # Success message
      redirect_to @property  # Redirect to property page with success message
    else
      # This will never happen in this case, but let's keep it here for fallback
      flash[:alert] = 'There was an error with your booking. Please try again.'
      redirect_to @property
    end
  end


  def show
    @booking = @property.bookings.find(params[:id])
  end

  def index
    @bookings = @property.bookings.all
  end


  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :number_of_guests)
  end
end
