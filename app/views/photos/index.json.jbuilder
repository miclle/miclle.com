json.array!(@photos) do |photo|
  json.extract! photo, :user_id, :album_id, :name, :description, :privacy
  json.url photo_url(photo, format: :json)
end
