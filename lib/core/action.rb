
require 'core/server'
require 'core/message'


module Core
    class Action 

        attr_accessor :target
        attr_reader :message
        attr_reader :server

        def initialize(message, server) 
            @message = message
            @server  = server 
            @target  = @message.has_channel? ? @message.channel : @message.nick
        end 

        def run(&block)
            instance_eval(&block)
        end

        def say(msg)
            @server.send "PRIVMSG #{@target} :#{msg}"
        end

        def me(msg)
            @server.send "PRIVMSG #{@target} \001ACTION #{msg}\001"
        end

        def notice(msg)
            @server.send "NOTICE #{@target} :#{msg}"
        end

        def join(channel)
            @server.join channel
        end
    end
end
