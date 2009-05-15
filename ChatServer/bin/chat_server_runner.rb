require 'rubygems'
require 'lib/chat_server'

DRb.start_service('druby://localhost:31337', ChatServer.new)
DRb.thread.join
