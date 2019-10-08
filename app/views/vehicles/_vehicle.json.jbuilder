json.extract! vehicle, :id, :make, :model, :user_id, :licence_plate, :color, :is_verified, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
