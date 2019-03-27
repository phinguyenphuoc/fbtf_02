class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail_sender
  layout "mailer"
end
