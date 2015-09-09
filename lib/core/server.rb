
require "net/protocol"

require 'core/message'

module Core

    class Server

        attr_reader   :bot
       
        attr_reader   :name

        attr_accessor :addr
        attr_accessor :port
        attr_accessor :nick
        attr_accessor :username
        attr_accessor :realname
        attr_accessor :password
        attr_accessor :channels

        def initialize(bot, name, &block)

            @bot      = bot
            @username = "rewheel"
            @realname = "rewheel - ruby bot"
            @nick     = nick
            @name     = name
            @socket   = nil
            
            if block_given?
                instance_eval(&block)
            end
        end

        [:warn, :fatal, :say].each do |level|
            define_method(level) do |msg|
                @bot.logger.send(level, "[#{@name}] " + msg)
            end
        end

        def send(raw)
            if !@socket
                fatal "Socket vanished...closing connection"
                return
            end
            say " < " + raw
            @socket.puts raw + "\r"
        end

        def join(channel)
            send "JOIN #{channel}"
        end

        def leave(channel, msg="")
            send "LEAVE #{channel} :#{msg}"
        end

        def setup
            Thread.new do
                sleep 2
                send "PASS #{@password}" if @password
                sleep 1
                send "NICK #{@nick}"
                sleep 1
                send "USER #{@username} 0 * :#{@realname}"
                sleep 5
                @channels.each do |channel|
                    send "JOIN #{channel}"
                end
            end
        end


        def connect

            if !@nick
                fatal "No nickname selected"
                return false
            end

            say "Connecting to #{@addr}:#{@port}"

            @socket = TCPSocket.open(@addr, @port, nil)

            Thread.new do
                begin
                    say "Thread is ready #{@name}"
                    while line = @socket.readline
                        say " > " + line
                        begin 
                            message = Core::Message.new(line, @name)

                            @bot.add_incoming(message)
                        rescue Core::Message::InvalidMessage
                            warn "Invalid message supplied"
                        end
                    end
                rescue Timeout::Error
                    warn "Connection timed out..."
                rescue EOFError
                    warn "Connection lost..."
                end
            end

            setup

        end
    end
end
