class WelcomeController < ApplicationController
  def index
    if session[:curr_user_id] != nil
        redirect_to({controller: "users", action: "display_profile"})
    end
  end
end
