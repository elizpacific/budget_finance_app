class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.notify.subject
  #
  def notify(email)
    mail to: email, subject: 'Hello there! We have smth new for you...'
  end
end
