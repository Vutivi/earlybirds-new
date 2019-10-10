json.extract! lead, :id, :trip_id, :first_name, :last_name, :cellphone, :email, :created_at, :updated_at
json.url lead_url(lead, format: :json)
