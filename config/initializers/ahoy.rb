class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = false
Ahoy.server_side_visits = :when_needed
Ahoy.track_bots = true
Ahoy.cookie_domain = :all
