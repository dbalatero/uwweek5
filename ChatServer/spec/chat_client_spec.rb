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

    before(:each) do
      @chat_server.should_receive(:add_observer)
      @chat_client = ChatClient.new('Nickname_1', 'User_1', @chat_server)
    end

    it "should add the specified channel to the list of channels" do
      @chat_client.join('Channel_1')
      @chat_client.channels.length.should eql(1)
      @chat_client.channels.include?('Channel_1').should be_true
    end 

  end

  describe ".leave" do

    before(:each) do
      @chat_server.should_receive(:add_observer)
      @chat_client = ChatClient.new('Nickname_1', 'User_1', @chat_server)
      @chat_client.join('Channel_1')
      @chat_client.join('Channel_2')
    end

    it "should remove the specified channel from the list of channels" do
      @chat_client.channels.length.should eql(2)
      @chat_client.channels.include?('Channel_1').should be_true
      @chat_client.channels.include?('Channel_2').should be_true
      @chat_client.leave('Channel_1')
      @chat_client.channels.length.should eql(1)
      @chat_client.channels.include?('Channel_1').should be_false
      @chat_client.channels.include?('Channel_2').should be_true
    end

  end

  describe ".send_message" do

    before(:each) do
      @chat_server.should_receive(:add_observer)
      @chat_client = ChatClient.new('Nickname_1', 'User_1', @chat_server)
      @chat_client.join('Channel_1')
    end

    it "should call the 'send_message' method on the chat server with the nickname, channel and message text" do
      @chat_server.should_receive(:send_message).with('Nickname_1', 'Channel_1', "Don't believe the hype!")
      @chat_client.send_message('Channel_1', "Don't believe the hype!")
    end

  end

  describe ".update" do

    before(:each) do
      @chat_server.should_receive(:add_observer)
      @chat_client = ChatClient.new('Nickname_1', 'User_1', @chat_server)
      @chat_client.join('Channel_1')
    end

    it "should print a message if the user belongs to the specified channel" do
      @chat_client.should_receive(:output_message).with("Nickname_From", "Channel_1", "ShamWOW!")
      @chat_client.update("Nickname_From", "Channel_1", "ShamWOW!")
    end

    it "should not print a message if the user does not belong to the specified channel" do
      @chat_client.should_not_receive(:output_message)
      @chat_client.update("Nickname_From", "Channel_2", "ShamWOW!")
    end

  end

end
