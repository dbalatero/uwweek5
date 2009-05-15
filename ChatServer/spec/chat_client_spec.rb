require 'rubygems'
require 'test/unit'
require 'spec'
require 'lib/chat_client.rb'
require 'lib/chat_server.rb'

describe ChatClient do

  before(:each) do
    @chat_server = mock(ChatServer)
  end

  describe ".initialize" do

    it "should add itself to the server's observer list" do
      @chat_server.should_receive(:add_observer)
      ChatClient.new('Nickname_1', 'User_1', @chat_server) 
    end

  end

  describe ".join" do

    

  end

  describe ".send_message" do

    it "should call the 'send_message' method on the chat server with the nickname, channel and message text"

  end

end
