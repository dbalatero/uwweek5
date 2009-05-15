require 'rubygems'
require 'lib/chat_client'
require 'drb/drb'

class ChatClientRunner

  def initialize(nickname, name, chat_server_uri)
    @nickname = nickname
    @name = name
    # create chat server instance
    @chat_server = DRbObject.new_with_uri(chat_server_uri)
    # create chat client instance, connect to chat server
    @chat_client = ChatClient.new(nickname, name, @chat_server)    
  end

  # do the thing
  def run
    while(command = gets)
      parse_command(command)
    end
  end 

  # parse commands
  def parse_command(command)

    # message command
    if command.match(/##message##.*##/)
      # find the channel and message
      channel, message = command.split(/##/)[2], command.split(/##/)[3]

      puts "Channel: #{channel}, message: #{message}"
    end
  end
end

# start the service
DRb.start_service
chat_server_uri = "druby://:31337"
chat_client_runner = ChatClientRunner.new(ARGV[0], ARGV[1], chat_server_uri)
chat_client_runner.run

# join a channel
#chat_client.join('Channel_1')

# send a message
#chat_client.send_message('Channel_1', 'This is a TEST message!')
