json.array!(@comments) do |comment|
  json.extract! comment, :id, :blurb
  json.url comment_url(comment, format: :json)
end
