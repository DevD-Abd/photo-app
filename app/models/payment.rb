class Payment < ApplicationRecord
    attr_accessor :stripe_token
    belongs_to :user
    
    validates :plan, presence: true, inclusion: { in: %w[premium amaze] }
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :stripe_token, presence: true, on: :create

    PLANS = {
      'premium' => { name: 'Premium Plan', amount: 900 }, # $9.00 in cents
      'amaze' => { name: 'Amaze Plan', amount: 1900 }     # $19.00 in cents
    }.freeze

    def plan_name
      PLANS[plan]&.dig(:name) || plan&.humanize
    end

    def plan_amount_in_dollars
      amount.to_f / 100
    end

    def process_payment
        return false unless valid?

        customer = Stripe::Customer.create(
            email: user.email,
            source: stripe_token
        )
    
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: amount,
            description: plan_name,
            currency: 'usd'
        )
    
        self.stripe_customer_id = customer.id
        self.stripe_charge_id = charge.id
        
        # Update user's plan
        user.update(plan: plan)
        
        save!
        rescue Stripe::CardError => e
            errors.add(:base, e.message)
            false
        rescue => e
            errors.add(:base, "Payment processing failed: #{e.message}")
            false
    end
end
