module FileWriteHelper

  class Write

    attr_accessor :data
    attr_accessor :path

    def initialize(data, path)
      @data = data
      @path = path
    end

    def run()
      File.open(@path, "w+") do |f|
        f.write(@data)
      end
    end

  end
end
