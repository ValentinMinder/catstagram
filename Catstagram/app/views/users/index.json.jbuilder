json.array!(@users) do |user|
  json.extract! user, :id, :username, :avatar_url, :biography
  json.url user_url(user, format: :json)
end
