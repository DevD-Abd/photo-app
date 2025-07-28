class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_one :payment
  accepts_nested_attributes_for :payment

  def has_plan?
    plan.present?
  end

  def plan_name
    case plan
    when 'premium'
      'Premium Plan'
    when 'amaze'
      'Amaze Plan'
    else
      'Free Plan'
    end
  end
end
