class ApiController < ApplicationController
  def snippets
    @snippets = CodeSnippet.includes(:user).last(10).reverse

  end
end
