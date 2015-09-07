
require 'time'

module Core
    class Message

        attr_reader :raw
        attr_reader :command
        attr_reader :params

        attr_reader :time

        attr_reader :origin
        attr_reader :target

        attr_reader :matches

        attr_reader :server
        attr_reader :bot

        def initialize(msg, server, bot)
            @raw    = msg
            @server = server
            @bot    = bot
            @time   = Time.now

            parse msg
        end

        def parse
            puts "\"#{@raw}\""
        end

    end


end
