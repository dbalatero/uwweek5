module HttpServer
  module ServerMethods
    def read_http(io)
      raw_request = ""
      io.each_line do |line|
        break if line == "\r\n"
        raw_request << line
      end
      raw_request
    end
  end
end

