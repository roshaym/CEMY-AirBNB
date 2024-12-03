class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]

  # GET all the listings
  def index
    @listings = Listing.all
  end

  # GET show all the listings by id
  def show
  end

  def new
    @listing = Listing.new
  end

  # POST > create listings
  def create
    @listing = current_user.listings.build(listing_params)
    if @listing.save
      redirect_to @listing, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end


  def edit
  end


  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: 'Listing was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE listing
  def destroy
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully destroyed.'
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :location)
  end
end
