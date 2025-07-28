class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @plan = params[:plan]
    unless [ "premium", "amaze" ].include?(@plan)
      redirect_to root_path, alert: "Please select a valid plan"
      return
    end

    redirect_to new_user_registration_path(plan: @plan)
  end

  def create
    # This action is handled by the custom registration controller
    redirect_to root_path
  end
end
