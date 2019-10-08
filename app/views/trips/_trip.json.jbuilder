json.extract! trip, :id, :kind, :slug, :start_location, :end_location, :seats, :price, :vehicle_id, :plan_id, :approved, :departure_times, :return_times, :round_trip, :created_at, :updated_at
json.url trip_url(trip, format: :json)
