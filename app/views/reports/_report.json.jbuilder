json.extract! report, :id, :trip_id, :user_id, :reason, :comment, :created_at, :updated_at
json.url report_url(report, format: :json)
