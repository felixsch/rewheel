require 'thread'
require 'ostruct'

require 'core/logger'
require 'core/server'
require 'core/action'

require 'util/concurrent'

module Core

    class Bot

        attr_reader :servers
        attr_reader :logger 
        attr_reader :worker_instances

        attr_reader :incoming
        attr_reader :outging


        attr_reader :debug


        def initialize(&block)

            @mutex      = Mutex.new
            @queue      = ConditionVariable.new

            @logger     = Logger.new(@debug)
            @debug      = false
            @incoming   = Queue.new
            @actions    = {:all => []}
            @worker_instances = 10

            @quit       = false

            @servers = {}
 
            if block_given?
                instance_eval(&block)
            end
        end

        def set_logger(logger)
            @logger = logger
        end

        def set_workers(size)
            @worker_instances = size
        end

        def add_server(name, &block)
            s = Core::Server.new(self, name, &block)
            @servers[name] = s
            @actions[name] = []
            @logger.debug("Server #{name} (#{s.addr}:#{s.port}) added...")
        end

        def add_incoming(message)
                @incoming.push(message)
        end

        def on(regex, &block)    
            @actions[:all].push(OpenStruct.new(:regex => regex, :block => block))
        end


        def start

            workers = spawn_workers

            @servers.each do |_, server|
                server.connect
            end

            until (@quit)
                sleep 1
            end
 
            workers.map(&:join) 

        end

        private
        def spawn_workers
            @worker_instances.times.each do |i|
                @logger.debug("Spawned ##{i} queue worker..")
                Thread.new do 
                    loop do
                        message = @incoming.pop
                        if message.is_ping?
                            @servers[message.server].send("PONG :#{message.params.first}")
                        else
                            handle_actions(message)
                        end
                    end
                end
            end
        end

        def handle_actions(message)

            matchers = @actions[:all]
            matchers.concat(@actions[message.server])

            matchers.each do |matcher|
                if matcher.regex =~ message.message
                   action = Core::Action.new(message, @servers[message.server])
                   action.run(matcher.block)
                end
            end
            
        end
    end
end
