require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe HttpServer::Router do
  describe "initialize" do
    it "should take a static content/template path" do
      lambda {
        HttpServer::Router.new
      }.should raise_error
      router = HttpServer::Router.new("/tmp/public")
      router.document_root.should == "/tmp/public"
    end
  end

  describe "add_handler" do
    before(:each) do
      @router = HttpServer::Router.new('/tmp/foo')
    end

    it "should take a route and proc, and save it" do
  
      lambda {
        @router.add_handler('/time') do |request, response|
          response.body = "The time is: #{Time.now}"
        end
      }.should_not raise_error
    end

    it "should require a proc" do
      lambda {
        @router.add_handler('/time')
      }.should raise_error(ArgumentError)
    end
  end

  describe "handle_request" do
    before(:each) do
      @router = HttpServer::Router.new("/tmp/foo")
      @request = mock
    end

    it "should handle static files that don't exist with a 404" do
      @request.should_receive(:path).at_least(:once).and_return("/kdjasf8900.html")
      response = @router.handle_request(@request)
      response.code.should == 404
    end

    it "should handle static files that exist with a 200" do
      @request.should_receive(:path).at_least(:once).and_return("/real.html")
      mock_file = mock
      mock_file.should_receive(:read).and_return("Content!")
      File.should_receive(:open).with("/tmp/foo/real.html", "r").and_yield(mock_file)

      response = @router.handle_request(@request)
      response.code.should == 200
      response.body.should == "Content!"
    end

    it "should handle erb files that don't exist with a 404" do
      @request.should_receive(:path).at_least(:once).and_return("/fdas8uf9jklfdas.html.erb")
      response = @router.handle_request(@request)
      response.code.should == 404
    end

    it "should handle erb files that do exist but are bad with 500" do
      @request.should_receive(:path).at_least(:once).and_return("/test.html.erb")
      File.should_receive(:read).with("/tmp/foo/test.html.erb").and_return("<%= kjfd890jffdsajkfldsa -%>")
      response = @router.handle_request(@request)
      response.code.should == 500
      response.body.should =~ /<h1>Error 500<\/h1>/
    end

    it "should handle erb files that do exist and are good with 200" do
      @request.should_receive(:path).at_least(:once).and_return("/test.html.erb")
      File.should_receive(:read).with("/tmp/foo/test.html.erb").and_return("The time is: <%= Time.now %>")
      
      response = @router.handle_request(@request)
      response.code.should == 200
      response.body.should =~ /The time is/
    end

    it "should handle correct servlets with code 200" do
      @request.should_receive(:path).at_least(:once).and_return("/time")
      @router.add_handler("/time") do |request, response|
        response.body = "Hello it's a test!"
      end

      response = @router.handle_request(@request)
      response.code.should == 200
      response.body.should == "Hello it's a test!"
    end

    it "should handle incorrect servlets with code 500" do
      @request.should_receive(:path).at_least(:once).and_return("/time")
      @router.add_handler("/time") do |request, response|
        raise "we're fucking up here"
      end

      response = @router.handle_request(@request)
      response.code.should == 500
    end
  end
end
