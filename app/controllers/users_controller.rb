# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end
end
