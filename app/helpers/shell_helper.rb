module ShellHelper
  class MyShell

    attr_accessor :command
    attr_accessor :out
    def initialize(command)
      @command = command
      @out = ""
    end

    def run
      Shell.execute(@command) do |stdout, stderr|
        if stdout
          @out += stdout
        else
          @out += stderr
        end
      end

      return @out
    end
  end
end
