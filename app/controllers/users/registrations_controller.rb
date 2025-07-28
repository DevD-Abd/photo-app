class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @plan = params[:plan]
    unless ['premium', 'amaze'].include?(@plan)
      redirect_to root_path, alert: 'Please select a valid plan'
      return
    end
    
    @user = User.new
    @payment = @user.build_payment(
      plan: @plan, 
      amount: Payment::PLANS[@plan][:amount]
    )
    
    # Set minimum password length for view
    @minimum_password_length = User.password_length.min
    
    # Use simple form for testing (you can change this to 'new' for Stripe Elements)
    render :new_simple
  end

  def create
    @plan = params.dig(:user, :payment_attributes, :plan)
    
    unless ['premium', 'amaze'].include?(@plan)
      redirect_to root_path, alert: 'Please select a valid plan'
      return
    end
    
    @user = User.new(user_params)
    @payment = @user.build_payment(payment_params)
    @minimum_password_length = User.password_length.min

    if @user.valid? && @payment.valid?
      if @payment.process_payment
        @user.save!
        if @user.confirmed?
          sign_in(@user)
          redirect_to root_path, notice: 'Welcome! Your account was created successfully and payment processed.'
        else
          redirect_to root_path, notice: 'Account created successfully! Please check your email to confirm your account.'
        end
      else
        @payment.errors.full_messages.each do |message|
          @user.errors.add(:base, message)
        end
        render :new_simple, status: :unprocessable_entity
      end
    else
      render :new_simple, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def payment_params
    params.require(:user).require(:payment_attributes).permit(
      :plan, :amount, :stripe_token
    )
  end
end
