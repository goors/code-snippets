class CodeController < ApplicationController

  # POST /submit
  # POST /submit.json
  def submit

    if !current_user.nil? and !params[:public]
      object = CodeSnippet.new(:title => params[:title], :body => params[:value], :code_type => params[:type], :user_id => current_user.id)
      if object.save()
        flash[:success] = "Great."
      else
        flash[:error] = "There is a problem with your request."
      end
    end

    extension = "c"

    if params[:type] == 'ruby'
      extension = "rb"
    else
      if params[:type] == 'rust'
        extension = "rust"
      end
    end

    fname = [*('A'..'Z')].sample(8).join
    path = File.dirname(__FILE__)+"/../../uploads/"+fname+"."+extension

    content = params[:value]
    File.open(path, "w+") do |f|
      f.write(content)
    end

    out = ""
    if extension == "rb"
      puts '/usr/bin/ruby '+path
      Shell.execute('/usr/bin/ruby '+path) do |stdout, stderr|
        if stdout
          out += stdout
        else
          out += stderr
        end
      end
    else
      if params[:type] == 'c'
        puts 'cd '+File.dirname(__FILE__)+'/../../uploads/ && gcc -o '+fname+' '+fname+".c && chmod a+x "+fname+ " && ./"+fname
        Shell.execute('cd '+File.dirname(__FILE__)+'/../../uploads/ && gcc -o '+fname+' '+fname+".c && chmod a+x "+fname+ " && ./"+fname) do |stdout, stderr|
          if stdout
            out += stdout
          else
            out += stderr
          end
        end
      end
    end
    respond_to do |format|
      format.json { render json: {:result => out} }
    end
  end


end
