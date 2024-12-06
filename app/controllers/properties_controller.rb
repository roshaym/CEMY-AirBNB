class PropertiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
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
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to create a property.'
      return
    end

    @property = current_user.properties.build(property_params)
    @property.rating ||= 0
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
    @property = current_user.properties.find(params[:id]) # Ensures only the owner can delete
    @property.destroy
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  rescue ActiveRecord::RecordNotFound
    redirect_to properties_path, alert: 'You are not authorized to delete this property.'
  end


  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :description, :price_per_night, :address, :user_id, :image_url)
  end

end
