class EmailValidator < ActionMailer::Base
  default from: 'admin@rastaman.com'

  def complete_registration(registrant)
    @url = "http://localhost:3000/register/#{registrant.sign_up_code}"

    mail to: registrant.email,
      subject: "Please complete your registration to Rastaman!"
  end

  def password_reset(user)
    @url = "http://localhost:3000/reset/#{user.reset_code}"
    
    mail to: user.email,
      subject: "Please reset your password for Rastaman!"
  end
end