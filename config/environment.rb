# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Learos::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app17000965@heroku.com',
  :password       => 'vackg8v8',
  :domain         => 'learos.com'
}

ActionMailer::Base.delivery_method = :smtp