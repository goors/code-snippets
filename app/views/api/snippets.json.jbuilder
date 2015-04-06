json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :title, :body, :code_type
  json.url user_url(snippet, format: :json)
  json.author snippet.user.name
  json.author_email snippet.user.email
end
