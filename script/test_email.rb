#!/usr/bin/env ruby

# Load Rails environment
require_relative '../config/environment'

puts "Testing Postmark configuration..."
puts "API Token: #{ENV['POSTMARK_API_TOKEN']}"
puts "From address: #{ApplicationMailer.default[:from]}"

# Test email delivery
begin
  # Test using ActionMailer directly
  puts "\nTesting email delivery..."

  ActionMailer::Base.mail(
    from: ApplicationMailer.default[:from],
    to: 'abdullahubaidullah@carecloud.com', # Back to your email
    subject: 'Test Email from Photo App',
    body: 'This is a test email to verify Postmark configuration.'
  ).deliver_now

  puts "✅ Email sent successfully!"
  puts "📧 Check your email inbox!"

rescue => e
  puts "❌ Error sending email: #{e.message}"
  puts "Error class: #{e.class}"
  puts "Backtrace: #{e.backtrace.first(5)}"
end
