class InviteUser < ApplicationMailer
  include SendGrid

  def send_invite_email(invitedUserEmail, current_user)
    @current_user = current_user
    @userEmail = invitedUserEmail
    mail( :to => @userEmail,
    :subject => "You've been invited to join Shopify Book Bar." )
  end
end
