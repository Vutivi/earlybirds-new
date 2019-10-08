1.times do
  user = User.create(email: "api_user@domain.com", password: "123456", password_confirmation: "123456")
  puts "User #{user.email} created"
end