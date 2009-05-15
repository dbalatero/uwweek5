require 'rubygems'
require 'test/unit'
require 'spec'
require 'lib/chat_server.rb'

describe ChatServer do
  before(:each) do
    @chat_server = ChatServer.new
  end

  describe ".send_message" do

    it "should send a message with the nickname, channel and message text" do
      @chat_server.should_receive(:changed).with(true)
      @chat_server.should_receive(:notify_observers).with('Nickname_1', 'Channel_1', 'Here come the drums (CONFUSION!)')
      @chat_server.send_message('Nickname_1', 'Channel_1', 'Here come the drums (CONFUSION!)')
    end

  end

end
