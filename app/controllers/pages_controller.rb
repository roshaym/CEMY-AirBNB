class PagesController < ApplicationController
  def home
    @properties = Property.all # Fetch all properties from the database
  end
end

# class PagesController < ApplicationController
# skip_before_action :authenticate_user!, only: :home
# def home
# end
# end
