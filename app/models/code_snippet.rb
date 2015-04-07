class CodeSnippet < ActiveRecord::Base
  belongs_to :user
  has_many :code_comments
end
