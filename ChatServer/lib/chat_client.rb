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
    # add this chat client to the list of observers for the chat server
    chat_server.add_observer(self)
  end

  

end
