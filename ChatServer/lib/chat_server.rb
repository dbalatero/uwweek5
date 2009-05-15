require 'rubygems'
require 'drb'
require 'drb/observer'
require 'set'

class ChatServer
  VERSION = '1.0.0'
  include DRb::DRbObservable

  def initialize
  end

  def send_message(from_nickname, channel, message_contents)
    # this tells DRb that there's something ready for sending
    changed(true)
    # this notifies all observers (duh)
    notify_observers(from_nickname, channel, message_contents)
  end

end
