class SnippetsController < ApplicationController

  def index
    @snippets = CodeSnippet.includes(:user).reverse
  end
  def new
    render :template => 'home/index'
  end

  def api
    @snpts = CodeSnippet.joins(:code_comments).includes(:user).last(10).reverse.uniq

  end

end
