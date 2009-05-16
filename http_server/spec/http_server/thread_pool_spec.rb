require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe HttpServer::ThreadPool do
  describe "initialize" do
    it "should take a router" do
      lambda {
        HttpServer::ThreadPool.new
      }.should raise_error
    end
  end

  describe "available_threads" do
    it "should return 20 by default" do
      tp = HttpServer::ThreadPool.new(mock)
      tp.available_threads.should == 20
    end
  end

  describe "run_request" do
    before(:each) do
      @router = HttpServer::Router.new("/tmp")
      @router.add_handler("/time") do |request, response|
        response.body = "The time is: #{Time.now}"
      end
      @pool = HttpServer::ThreadPool.new(@router, 5)
    end

    it "should successfully do an HTTP GET" do
      socket = StringIO.new("GET /time HTTP/1.1\r\n\r\n")
      @pool.run_request(socket)
      # this seems like a race condition
      socket.string.should =~ /OK/
    end
  end
end
