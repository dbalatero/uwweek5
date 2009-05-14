module HttpServer
  class Request
    attr_accessor :path, :protocol, :headers

    def initialize(raw_request)
      @headers = {}
      parse!(raw_request)
    end

    private
    def parse!(raw_request)
      raw_request.each_line do |line|
        line.strip!
        if line =~ /GET (\/[^\s]+) HTTP\/(\d+.\d+)/
          @path = $1
          @protocol = $2
        elsif line =~ /(.+): (.+)/
          @headers[$1] = $2
        end
      end
    end
  end
end
