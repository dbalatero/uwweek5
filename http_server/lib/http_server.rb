$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'http_server/request'
require 'http_server/response'
require 'http_server/router'

module HttpServer
  CRLF = "\r\n"
  VERSION = '1.0.0'
end
