module HttpServer
  class Response
    attr_accessor :body, :code, :headers
    def initialize
      @body = ''
      @code = 200
      @headers = {}
    end

    def raw_http
      resp = ""
      case @code
      when 200
        resp << "HTTP/1.1 200 OK" << HttpServer::CRLF
        resp << "Date: #{http_date}" << HttpServer::CRLF
        resp << "Content-Length: #{@body.length}" << HttpServer::CRLF
        resp << "Content-Type: text/html" << HttpServer::CRLF
        resp << HttpServer::CRLF
        resp << @body
      when 404
        resp << "HTTP/1.1 404 Not Found" << HttpServer::CRLF
        resp << HttpServer::CRLF
        resp << "404 page not found"
      when 500
        resp << "HTTP/1.1 500 Internal Server Error" << HttpServer::CRLF
        resp << HttpServer::CRLF
        resp << @body
      else
        raise "Unsupported HTTP code!"
      end
      resp
    end

    private
    def http_date
      Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")
    end
  end
end
