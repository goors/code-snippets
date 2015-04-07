class HomeController < ApplicationController

  def index
    @last_snippet = CodeSnippet.includes(:user).last(1).reverse

  end

  def snippet

    id = params[:id]
    @snippet = CodeSnippet.find(id)
    @id = id
    @comments = CodeComment.where(["code_snippet_id = :u", { u: id }])

    render :template => 'home/index'
  end

  def my_snippets


    @snippets = CodeSnippet.where(["user_id = :u", { u: current_user.id }])
    render :template => 'snippets/index'

  end

  def comment

    object = CodeComment.new(:body => params[:comment], :user_id => current_user.id, :code_snippet_id => params[:snippet_id])
    if object.save()
      respond_to do |format|
        format.json { render json: {:result => {:created_at => object.created_at, :comment => object.body}} }
      end
    else
      flash[:error] = "There is a problem with your request."
    end


  end
end
