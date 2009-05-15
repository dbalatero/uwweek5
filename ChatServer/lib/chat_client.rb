require 'rubygems'
require 'drb'
require 'drb/observer'
require 'set'

class ChatClient
  VERSION = '1.0.0'
  include DRbUndumped

  attr_accessor :nickname, :name, :channels

  def initialize(nickname, name, chat_server)
    @nickname = nickname
    @name = name
    @channels = Set.new
    @chat_server = chat_server
    # add this chat client to the list of observers for the chat server
    chat_server.add_observer(self)
  end

  def join(channel_name)
    # track which channels we're in locally for later filtering of
    # messages
    unless channels.include?(channel_name)
      channels.add(channel_name)

      # announce the fact that this client has joined this channel
      @chat_server.send_message(@nickname, channel_name, "#{@nickname} has joined #{channel_name}")
    end
  end

  def leave(channel_name)
    # remove the specified channel from the list
    if channels.include?(channel_name)
      channels.delete(channel_name)

      # announce the fact that this client has left this channel
      @chat_server.send_message(@nickname, channel_name, "#{@nickname} has left #{channel_name}")
    end
  end

  def send_message(channel_name, message_contents)
    if channels.include?(channel_name)
      @chat_server.send_message(@nickname, channel_name, message_contents)
    end
  end

  def update(from_nickname, channel_name, message_contents)
    # check if we belong to that channel
    if @channels.include?(channel_name)
      output_message(from_nickname, channel_name, message_contents)
    end
  end

  def output_message(from_nickname, channel_name, message_contents)
      puts "[#{channel_name} : #{from_nickname}] #{message_contents}"
  end

end
