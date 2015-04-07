class CodeComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :code_snippet
end
