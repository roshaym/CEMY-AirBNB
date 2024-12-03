class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    if params[:query].present?
      @properties = @properties.where("location ILIKE ?", "%#{params[:query]}%")
    end
  end

  # def search
  #   if params[:query]
  #     @property = @properties.select { |property| property.location.start_with?(params[:query]) }
  #   end

  # end

  private

  def properties_params
    params.require(:property).permit(:query)
  end

end
