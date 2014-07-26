json.array!(@albums) do |album|
  json.extract! album, :user_id, :title, :description, :photo_count, :privacy
  json.url album_url(album, format: :json)
end
