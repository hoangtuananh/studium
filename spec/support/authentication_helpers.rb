module AuthenticationHelpers
  def create_user!(attr={email: "user@ticketee.com",password: "password"})
    User.create! attr
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end
