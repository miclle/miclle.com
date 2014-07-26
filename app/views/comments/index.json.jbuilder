json.array!(@comments) do |comment|
  json.extract! comment, :user_id, :entity_type, :entity_id, :content, :deleted_at, :reason
  json.url comment_url(comment, format: :json)
end
