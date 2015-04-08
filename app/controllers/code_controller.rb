class CodeController < ApplicationController

  def submit

    if !current_user.nil? and !params[:public]
      object = CodeHelper::Req.new(params, current_user)
      object.add_code()

      if object
        flash[:success] = "Great."
      else
        flash[:error] = "There is a problem with your request."
      end
    end

    out = CodeHelper::Req.new(params, current_user)
    out = out.execute_code()

    respond_to do |format|
      format.json { render json: {:result => out} }
    end
  end


end
