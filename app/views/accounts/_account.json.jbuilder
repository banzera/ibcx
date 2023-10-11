json.extract! account, :id, :user_id, :type, :username, :password, :created_at, :updated_at
json.url account_url(account, format: :json)
