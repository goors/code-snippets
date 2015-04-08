json.array!(@snpts) do |snippet|
  json.extract! snippet, :id, :title, :body, :code_type
  json.author_email snippet.user.email
  json.comments snippet.code_comments
end
