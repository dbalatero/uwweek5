require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe HttpServer::Request do
  describe "initialize" do
    before(:each) do
      raw = "GET /index.html HTTP/1.0\r\n" <<
            "Header-Test: test\r\n" <<
            "Header-Test2: test2\r\n\r\n"
      @request = HttpServer::Request.new(raw)
    end

    it "should parse the path from a GET request" do
      @request.path.should == '/index.html'
    end

    it "should parse the protocol from a GET request" do
      @request.protocol.should == '1.0'
    end

    it "should parse the headers from a GET request" do
      @request.headers['Header-Test'].should == 'test'
      @request.headers['Header-Test2'].should == 'test2'
    end
  end
end
