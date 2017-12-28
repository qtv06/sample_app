class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation user
    @user = user
    mail to: @user.email, subject: I18n.t("mailer.subject")
  end

  def password_reset
    @greeting = I18n.t("mailer.hi_text")
    mail to: "to@example.org"
  end
end
