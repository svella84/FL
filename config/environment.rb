# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Farmland::Application.initialize!

Farmland::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  	address: "smtp.gmail.com",
  	port: "587",
  	domain: "baci.lindsaar.net",
  	authentication: :plain,
  	user_name: "farmland.sv@gmail.com",
  	password: "free.willy",
  	enable_starttls_auto: true
  }
end
