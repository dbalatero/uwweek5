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
end
