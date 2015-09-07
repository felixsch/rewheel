require "net/protocol"

module Core

    class Server

        attr_reader   :bot
       
        attr_reader   :name

        attr_accessor :addr
        attr_accessor :port
        attr_accessor :username
        attr_accessor :password
        attr_accessor :channels

        def initialize(bot, name, username, &block)
            @bot      = bot
            @username = username
            @name     = name
            
            if block_given?
                instance_eval(&block)
            end
        end

        def to_s
            str = "#{@name} — #{@addr}:#{@port}\n"
            str += " '- username = #{@username.join(" ")}\n" if @username
            str += " '- password = #{@password}\n" if @password
            str += " '- channels = #{@channels.join(" ")}\n" if @channels
            return str
        end

        def connect

            @bot.logger.say("Connection to #{@addr}:#{@port}")

            @socket = TCPSocket.new(@addr, @port, nil)

            begin
                @thread = Thread.new do
                    while line = @socket.readline
                        @bot.incoming << Core::Message.new(bot, self, line)
                    end
                end
            rescue Timeout::Error
                @bot.logger.warn("[#{@name}] Connection timed out...")
            rescue EOFError
                @bot.logger.warn("[#{@name}] Connection lost...")
            end

            @socket.close
        end
    end
end
