class UserMailer < ActionMailer::Base
  default from: "mighty_admin@rottenmangoes.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email,
         subject: 'Welcome to My Awesome Site',
         template_path: 'notifications',
         template_name: 'another')
  end

  def notify_delete_email(user)
    @user = user
    @url  = 'http://rottenmangoes.com/'
   	mail(to: @user.email,
        subject: 'Account Deletion Notice',
     	  template_path: 'user_mailer',
        template_name: 'notify_delete_email')
	end
	
end
