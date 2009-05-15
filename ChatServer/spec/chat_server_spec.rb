require 'rubygems'
require 'test/unit'
require 'spec'
require 'lib/chat_server.rb'
describe ChatServer do
  before(:each) do
    @chat_server = ChatServer.new
  end

  describe ".initialize" do
    
    it "should have a users object after initializing" do
      @chat_server.users.should_not be_nil
    end

    it "should have a channels object after initializing" do
      @chat_server.channels.should_not be_nil
    end

  end

  describe ".join" do

    it "should allow a user to join a channel" do
      @chat_server.join('Nickname_1', 'User_1', 'Channel_1')
      @chat_server.users['Nickname_1'].should_not be_nil
      @chat_server.users['Nickname_1']['name'].should eql('User_1')
      @chat_server.channels['Channel_1'].should_not be_nil
      # debugger
      @chat_server.channels['Channel_1'][:users].include?('Nickname_1').should be_true
    end

    it "should not create a second channel when another user joins" do
      @chat_server.join('Nickname_1', 'User_1', 'Channel_1')
      @chat_server.join('Nickname_2', 'User_2', 'Channel_1')
      @chat_server.channels.length.should eql(1)
    end

    it "should not create a second user with the same nickname" do
      @chat_server.join('Nickname_1', 'User_1', 'Channel_1')
      @chat_server.join('Nickname_1', 'User_Duplicate', 'Channel_1')
      @chat_server.users['Nickname_1']['name'].should eql('User_1')
      @chat_server.channels['Channel_1'][:users].length.should eql(1)
    end

    it "should allow existing users to join a second channel" do
      @chat_server.join('Nickname_1', 'User_1', 'Channel_1')
      @chat_server.join('Nickname_1', 'User_1', 'Channel_2')
      @chat_server.users['Nickname_1']['name'].should eql('User_1')
      @chat_server.channels['Channel_1'][:users].length.should eql(1)
      @chat_server.channels['Channel_2'].should_not be_nil
      @chat_server.channels['Channel_2'][:users].length.should eql(1)
    end

  end

  describe ".leave" do

    before(:each) do
      @chat_server.join('Nickname_1', 'User_1', 'Channel_1')
      @chat_server.join('Nickname_2', 'User_2', 'Channel_1')
      @chat_server.join('Nickname_3', 'User_3', 'Channel_2')
    end

    it "should allow a user to leave a channel" do
      @chat_server.leave('Nickname_1', 'Channel_1')
      @chat_server.channels['Channel_1'][:users].length.should eql(1)
      @chat_server.channels['Channel_1'][:users].include?('Nickname_1').should be_false
    end

    it "should delete a channel when the last user leaves" do
      @chat_server.leave('Nickname_1', 'Channel_1')
      @chat_server.leave('Nickname_2', 'Channel_1')
      @chat_server.channels['Channel_1'].should be_nil
    end

  end

end
