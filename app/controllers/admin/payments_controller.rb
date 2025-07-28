class Admin::PaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @payments = Payment.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @payment = Payment.find(params[:id])
  end

  private

  def authenticate_admin!
    # Simple admin check - in production, use a proper admin system
    unless current_user&.email&.ends_with?('@admin.com')
      redirect_to root_path, alert: 'Access denied'
    end
  end
end
