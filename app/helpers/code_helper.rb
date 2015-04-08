module CodeHelper

  class Req

    attr_accessor :params
    attr_accessor :user

    def initialize(req, user)

      @params = req
      @user = user

    end

    def add_code()

      object = CodeSnippet.new(:title => @params[:title], :body => @params[:value], :code_type => @params[:type], :user_id => @user.id)
      if object.save()
        return TRUE
      else
        return FALSE
      end

    end

    def execute_code

      #get extension
      extension = extension()

      #format data for write
      fname = [*('A'..'Z')].sample(8).join
      path = File.dirname(__FILE__)+"/../../uploads/"+fname+"."+extension

      #write to file
      write = FileWriteHelper::Write.new(@params[:value], path)
      write.run()

      out = ""
      if extension == "rb"
        out = ShellHelper::MyShell.new('/usr/bin/ruby '+path)
        out = out.run()
      else
        if extension == 'c'
          out = ShellHelper::MyShell.new('cd '+File.dirname(__FILE__)+'/../../uploads/ && gcc -o '+fname+' '+fname+".c && chmod a+x "+fname+ " && ./"+fname)
          out = out.run()
        end
      end

      return out
    end

    def extension()
      extension = "c"
      if @params[:type] == 'ruby'
        extension = "rb"
      else
        if @params[:type] == 'rust'
          extension = "rust"
        end
      end
      return extension
    end
  end
end
