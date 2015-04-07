class ApiController < ApplicationController
  def snippets
    #@snpts = CodeSnippet.includes(:user).last(10).reverse
    @snpts = CodeSnippet.joins(:code_comments).includes(:user).last(10).reverse.uniq



  end
end
