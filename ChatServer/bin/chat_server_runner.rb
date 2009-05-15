require 'rubygems'
require 'drb/drb'
require 'lib/chat_server'

DRb.start_service('druby://:31337', ChatServer.new)
DRb.thread.join
