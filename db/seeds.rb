require 'csv'

plans_csv_text = File.read(Rails.root.join('lib', 'seeds', 'plans.csv'))
plans_csv = CSV.parse(plans_csv_text, :headers => true, :encoding => 'ISO-8859-1')

category_csv_text = File.read(Rails.root.join('lib', 'seeds', 'categories.csv'))
category_csv = CSV.parse(category_csv_text, :headers => true, :encoding => 'ISO-8859-1')

events_csv_text = File.read(Rails.root.join('lib', 'seeds', 'events.csv'))
event_csv = CSV.parse(events_csv_text, :headers => true, :encoding => 'ISO-8859-1')

users_csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
users_csv = CSV.parse(users_csv_text, :headers => true, :encoding => 'ISO-8859-1')


plans_csv.each do |row|
  p               = Plan.new
  p.name          = row['name']
  p.id            = row['id']
  p.price         = row['price']
  p.daily_price   = row['daily_price']
  p.length        = row['length']
  p.catch_phrase  = row['catch_phrase']
  p.description   = row['description']
  p.perks         = row['perks']

  p.save(validate: false)
  puts "#{p.name} plan created"
end

category_csv.each do |row|
  c             = Category.new
  c.id          = row['id']
  c.name        = row['name']
  c.description = row['description']
  c.slug        = row['slug']
  c.save(validate: false)
  puts "#{c.name} category stored"
end

event_csv.each do |row|
  e             = Event.new
  e.id          = row['id']
  e.name        = row['name']
  e.description = row['description']
  e.address     = row['address']
  e.start_time  = row['start_time']
  e.end_time    = row['end_time']
  e.ticket_link = row['ticket_link']
  e.expired     = row['expired']
  e.category_id = row['category_id']
  e.slug        = row['slug']
  e.save(validate: false)
  puts "#{e.name} event stored"
end

users_csv.each do |row|
  u = User.new
  u.id = row['id']
  u.email = row['email']
  u.first_name = row['full_name'].split(' ')[0]
  u.last_name  = row['full_name'].split(' ')[1]
  u.encrypted_password = row['encrypted_password']
  u.reset_password_token = row['reset_password_token']
  u.reset_password_sent_at = row['reset_password_sent_at']
  u.remember_created_at = row['remember_created_at']
  u.sign_in_count = row['sign_in_count']
  u.current_sign_in_at = row['current_sign_in_at']
  u.last_sign_in_at = row['last_sign_in_at']
  u.current_sign_in_ip = row['current_sign_in_ip']
  u.last_sign_in_ip = row['last_sign_in_ip']
  u.confirmation_token = row['confirmation_token']
  u.confirmed_at = row['confirmed_at']
  u.confirmation_sent_at = row['confirmation_sent_at']
  u.unconfirmed_email = row['unconfirmed_email']
  u.created_at = row['created_at ']
  u.updated_at = row['updated_at']
  u.provider = row['provider']
  u.uid = row['uid']
  u.tokens = row['tokens']
  u.cellphone = row['cellphone']

  if u.save(validate: false)
    u.profile_image.attach(io: open(row['image_url']), filename: "#{u.first_name}#{u.id}.png")
  else
    puts u.errors.full_messages
  end

  puts "#{u.first_name} has been stored succesfully!"
end

