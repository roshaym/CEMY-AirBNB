module ApplicationHelper
  def show_navbar?
    !(controller_name == "sessions" && action_name == "new") && # users/sign_in
      !(controller_name == "registrations" && action_name == "new") && # users/sign_up
      !(controller_name == "passwords" && action_name == "new") # forgot password
  end
end
