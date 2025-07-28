class ApplicationMailer < ActionMailer::Base
  # Change this to your verified Postmark sender signature
  default from: "abdullahubaidullah@carecloud.com"
  layout "mailer"
end
