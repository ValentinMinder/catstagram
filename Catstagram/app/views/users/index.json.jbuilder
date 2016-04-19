json.array!(@users) do |user|
  json.extract! user, :id, :username, :avatar_url, :biography, :banned_until
  json.url user_url(user, format: :json)
end
