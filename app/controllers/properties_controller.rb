class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all

    @markers = @properties.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat})
      }
    end

    if params[:query].present?
      @properties = @properties.where("address ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @property = Property.find(params[:id])
    @booking = @property.bookings.build  # Initialize @booking for the form
  end

  def home
    @properties = Property.all

    @markers = @properties.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat})
      }
    end

    if params[:query].present?
      @properties = @properties.where("address ILIKE ?", "%#{params[:query]}%")
    end
  end

  def new
    @property = Property.new
  end

  # POST > create listings
  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end


  def edit
  end


  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE listing
  def destroy
    @property.destroy
    redirect_to property_url, notice: 'Property was successfully destroyed.'
  end


  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :description, :price_per_night, :address)
  end

end
