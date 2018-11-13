json.extract! audit, :id, :title, :description, :department, :user_id, :created_at, :updated_at
json.url audit_url(audit, format: :json)
