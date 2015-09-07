
require 'core/logger'
require 'core/server'

module Core

    class Bot
        attr_reader :servers
        attr_reader :logger 

        attr_reader :debug

        def initialize(&block)

            @logger  = Logger.new(@debug)
            @debug   = false
            @queue   = Queue.new
            @servers = {}
 
            if block_given?
                instance_eval(&block)
            end


        end

        def set_logger(logger)
            @logger = logger
        end

        def add_server(name, &block)
            s = Core::Server.new(name, @default_username, &block)
            @servers[name] = s
            @logger.debug("Server #{name} (#{s.addr}:#{s.port}) added...")
        end

        def start 
            server_strs = @servers.each { |_,s| s.to_s }.to_a
            puts server_strs.join("\n")        
        end
    end
end
