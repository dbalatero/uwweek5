require 'rubygems'
require 'lib/chat_client'
require 'drb/drb'

# start the service
DRb.start_service

# connect to the server
chat_server = DRbObject.new_with_uri('druby://:31337')

# initialize client
chat_client = ChatClient.new('Nickname_1', 'User_1', chat_server)

# join a channel
chat_client.join('Channel_1')

# send a message
chat_client.send_message('Channel_1', 'This is a TEST message!')
