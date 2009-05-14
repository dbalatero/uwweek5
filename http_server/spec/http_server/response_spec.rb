require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe HttpServer::Response do
  describe "initialize" do
    before(:each) do
      @resp = HttpServer::Response.new
    end

    it "should have a blank body on initialization" do
      @resp.body.should be_empty
    end

    it "should have a default response code of 200" do
      @resp.code.should == 200
    end
  end

  describe "code" do
    it "should be settable" do
      @resp = HttpServer::Response.new
      @resp.code = 500
      @resp.code.should == 500
    end
  end

  describe "body" do
    it "should be settable" do
      @resp = HttpServer::Response.new
      @resp.body = "<html>"
      @resp.body.should == "<html>"
    end
  end

  describe "headers" do
    it "should be settable" do
      @resp = HttpServer::Response.new
      @resp.headers['test'] = "ok"
      @resp.headers['test'].should == 'ok'
    end
  end

  describe "raw_http" do
    describe "200 responses" do
      before(:each) do
        @resp = HttpServer::Response.new
        @resp.code = 200
        @resp.body = "bodybody"
      end

      it "should return 200 OK" do
        @resp.raw_http.should =~ /HTTP\/1.1 200 OK/
      end

      it "should return Date, Content-Length, Content-Type" do
        ["Date:", "Content-Length:", "Content-Type:"].each do |key|
          @resp.raw_http.should =~ /#{key}/
        end
      end

      it "should have a body" do
        @resp.raw_http.should =~ /bodybody$/
      end
    end
    
    describe "404 responses" do
      before(:each) do
        @resp = HttpServer::Response.new
        @resp.code = 404
      end

      it "should return 404 Not Found" do
        @resp.raw_http.should =~ /HTTP\/1.1 404 Not Found/
      end
    end

    describe "500 responses" do
      before(:each) do
        @resp = HttpServer::Response.new
        @resp.code = 500
      end

      it "should return 500 Internal Server Error" do
        @resp.raw_http.should =~ /HTTP\/1.1 500 Internal Server Error/
      end
    end
  end
end
