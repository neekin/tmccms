json.array!(@auths) do |auth|
  json.extract! auth, :id, :auth_name, :auth_pid, :auth_path, :auth_controller, :auth_action, :auth_level
  json.url auth_url(auth, format: :json)
end
