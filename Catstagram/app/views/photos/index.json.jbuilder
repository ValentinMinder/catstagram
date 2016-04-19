json.array!(@photos) do |photo|
  json.extract! photo, :id, :image_url, :caption, :view_count, :like_count, :report_count
  json.url photo_url(photo, format: :json)
end
