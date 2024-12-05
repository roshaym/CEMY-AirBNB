class UsersController < ApplicationController
  def show
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_picture)
  end
end
