require 'rubygems'
require 'drb'
require 'drb/observer'
require 'set'

class ChatServer
  VERSION = '1.0.0'
  include DRb::DRbObservable

  attr_accessor :users, :channels

  def initialize
    @users = {}
    @channels = {}
  end

  def join(nickname, name, channel)
    # Create user if they don't yet exist
    if @users[nickname].nil?
      @users[nickname] = {'name' => name }
    end

    # Create channel if it doesn't yet exist
    if @channels[channel].nil?
      @channels[channel] = { :users => Set.new }
      @channels[channel][:users].add(nickname) 
    else
      unless @channels[channel][:users].include?(nickname)
        @channels[channel][:users].add(nickname)
      end
    end
  end

  def leave(nickname, channel)
    @channels[channel][:users].delete(nickname)

    # Delete the channel if the last user leaves
    if @channels[channel][:users].empty?
      @channels[channel] = nil
    end
  end

  def send_message(from_nick, channel, message_contents)
    # this tells DRb that there's something ready for sending
    changed(true)
    # this notifies all observers (duh)
    notify_observers(from_nick, channel, message_contents)
  end

end
