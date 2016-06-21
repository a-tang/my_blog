class AccountVerificationsMailer < ApplicationMailer
  def send_verification_instructions(user)
    @user = user
    mail(to: @user.email, subject: "Account Verification Instructions")
  end
end
