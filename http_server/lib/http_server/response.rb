module HttpServer
  class Response
    attr_accessor :body, :code, :headers
    def initialize
      @body = ''
      @code = 200
      @headers = {}
    end
  end
end
