require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe HttpServer::ServerMethods do
  include HttpServer::ServerMethods

  describe "read_http" do
    it "should read up to a \r\n" do
      s = StringIO.new(
        "GET / HTTP/1.1\r\n" +
        "Set-Cookie: fdasjklfi2fkldsafkjdlsa\r\n" +
        "\r\n")
      result = read_http(s)
      result.should =~ /^GET/
      result.should =~ /Set-Cookie/
    end
  end
end
