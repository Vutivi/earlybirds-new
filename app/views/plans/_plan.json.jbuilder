json.extract! plan, :id, :name, :price, :length, :catch_phrase, :description, :perks, :created_at, :updated_at
json.url plan_url(plan, format: :json)
