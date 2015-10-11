json.array!(@roles) do |role|
  json.extract! role, :id, :role_name, :role_auth_ids, :role_auth_ac
  json.url role_url(role, format: :json)
end
