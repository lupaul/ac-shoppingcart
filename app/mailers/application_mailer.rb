class ApplicationMailer < ActionMailer::Base
  # default from: 'from@example.com'
  default from: "service@alphacmp.com"
  layout 'mailer'
end
