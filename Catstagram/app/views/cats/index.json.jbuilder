json.array!(@cats) do |cat|
  json.extract! cat, :id, :catname, :description, :city, :birth_time
  json.url cat_url(cat, format: :json)
end
