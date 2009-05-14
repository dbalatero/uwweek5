require 'erb'

module HttpServer
  class Router
    attr_reader :document_root

    def initialize(document_root)
      @servlets = {}
      @document_root = document_root
    end

    def handle_request(request)
      response = HttpServer::Response.new
      handler = nil
      if @servlets[request.path]
        handler = servlet_handler(@servlets[request.path])
      else 
        if request.path =~ /.erb$/
          handler = erb_template_handler
        else
          handler = static_file_handler
        end
      end
      handler.call(request, response)
      response
    end

    def add_handler(path, &handler_proc)
      raise ArgumentError, "Handler proc required!" unless block_given?
      @servlets[path] = handler_proc
    end

    private
    def servlet_handler(servlet_proc)
      lambda { |request, response|
        begin
          servlet_proc.call(request, response)
        rescue Exception => error
          response.code = 500
          response.body = "<h1>Error 500</h1>" << error.inspect
        end
      }
    end

    def static_file_handler
      lambda { |request, response|
        begin
          File.open("#{@document_root}#{request.path}", "r") do |f|
            response.body = f.read
          end
        rescue Errno::ENOENT => error
          response.code = 404
        end
      }
    end

    def erb_template_handler
      lambda { |request, response|
        begin
          contents = File.read("#{@document_root}#{request.path}")
          erb = ERB.new(contents).src
          response.body = eval(erb, binding)
        rescue Errno::ENOENT => error
          response.code = 404
        rescue Exception => error
          response.code = 500
          response.body = "<h1>Error 500</h1>" << error.inspect
        end
      }
    end
  end
end
