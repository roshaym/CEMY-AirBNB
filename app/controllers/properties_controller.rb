class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    if params[:query].present?
      @properties = @properties.where("location ILIKE ?", "%#{params[:query]}%")
    end
  end
  def show
    @property = Property.find(params[:id])
  end

  private

  def properties_params
    params.require(:property).permit(:query)
  end

end
