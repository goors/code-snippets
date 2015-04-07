class SnippetsController < ApplicationController

  def index
    @snippets = CodeSnippet.includes(:user).reverse
  end
  def new
    render :template => 'home/index'
  end


end
