= ChatServer

* http://github.com/dbalatero/uwweek5/tree/master 

== DESCRIPTION:

This is a DRb-based chat server and client.  It supports multiple channels and users.  

== FEATURES/PROBLEMS:

drb-based centralized chat server & client

    * port 31337
    * multiple users, nick
    * multiple channels
    * join/leave
    * no protocol otherwise
    * client does no authentication, just connects.
    * server announces connection, etc.
    * protocol is objects, not text.

== SYNOPSIS:

To run chat server: ruby bin/chat_server_runner.rb
To run chat client: ruby bin/chat_client_runner.rb <nickname> <user_name>

In the client, the syntax for joining a channel is "##join##channel_name##".  The syntax for leaving a channel is "##leave##channel_name##".  The syntax for sending a message is "##channel_name##message".

== REQUIREMENTS:

N/A (just standard Ruby libraries)

== INSTALL:

N/A

== LICENSE:

(The MIT License)

Copyright (c) 2009 Peter Held, David Balatero

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
