#!/usr/bin/env ruby
# Stripe Test Script
# Run with: rails runner script/test_stripe.rb

puts "Testing Stripe Integration..."
puts "=" * 50

# Check Stripe configuration
puts "Stripe Publishable Key: #{Rails.configuration.stripe[:publishable_key][0..20]}..."
puts "Stripe Secret Key: #{Rails.configuration.stripe[:secret_key][0..20]}..."

# Test Stripe connection
begin
  balance = Stripe::Balance.retrieve
  puts "✓ Stripe connection successful"
  puts "  Available balance: $#{balance.available.first.amount / 100.0}"
rescue => e
  puts "✗ Stripe connection failed: #{e.message}"
end

# Test with Stripe test tokens
puts "\nTesting with Stripe test tokens..."
test_tokens = {
  'visa' => 'tok_visa',
  'visa_debit' => 'tok_visa_debit',
  'mastercard' => 'tok_mastercard',
  'declined' => 'tok_chargeDeclined'
}

test_tokens.each do |card_type, token|
  begin
    customer = Stripe::Customer.create(
      email: 'test@example.com',
      source: token
    )
    puts "✓ #{card_type.humanize} token test passed (Customer: #{customer.id})"
  rescue Stripe::CardError => e
    puts "⚠ #{card_type.humanize} token failed as expected: #{e.message}"
  rescue => e
    puts "✗ #{card_type.humanize} token test error: #{e.message}"
  end
end

# Test Payment model with token
puts "\nTesting Payment model with token..."
payment = Payment.new(
  plan: 'premium',
  amount: 900,
  stripe_token: 'tok_visa'
)

if payment.valid?
  puts "✓ Payment model validation passed with token"
else
  puts "✗ Payment model validation failed:"
  payment.errors.full_messages.each { |msg| puts "  - #{msg}" }
end

puts "=" * 50
puts "Test completed!"
puts "\nRecommended test tokens:"
puts "- Success: tok_visa, tok_mastercard"
puts "- Decline: tok_chargeDeclined"
puts "- Insufficient funds: tok_chargeDeclinedInsufficientFunds"
