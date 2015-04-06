class CodeController < ApplicationController

  # POST /submit
  # POST /submit.json
  def submit

    '''object = CodeSnippet.new(:title => params[:title], :body => params[:value], :code_type => params[:type], :user_id => current_user.id)
    if object.save()
      flash[:success] = "Great."
    else
      flash[:error] = "There is a problem with your request."
    end'''

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


    if extension == "ruby"
      puts '/usr/bin/ruby -r '+path
      Shell.execute('/usr/bin/ruby '+path) {|stdout| print stdout }
    else
      if params[:type] == 'c'
        puts 'cd '+File.dirname(__FILE__)+'/../../uploads/ && gcc -o '+fname+' '+fname+".c && chmod a+x "+fname+ " && ./"+fname
        Shell.execute('cd '+File.dirname(__FILE__)+'/../../uploads/ && gcc -o '+fname+' '+fname+".c && chmod a+x "+fname+ " && ./"+fname) {|stdout| print stdout }
      end
    end
  end


end
