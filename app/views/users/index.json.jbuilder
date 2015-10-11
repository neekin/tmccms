json.array!(@users) do |user|
  json.extract! user, :id, :name, :password_digest, :avatar, :email, :phone, :auth_token, :role_id
  json.url user_url(user, format: :json)
end
