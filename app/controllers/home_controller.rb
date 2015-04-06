class HomeController < ApplicationController
  def index
    @last_snippet = CodeSnippet.includes(:user).last(1).reverse
  end
end
