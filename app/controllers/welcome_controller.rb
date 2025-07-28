class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    if user_signed_in?
      @user_plan = current_user.plan_name
    end
  end
end
