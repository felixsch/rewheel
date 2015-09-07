
require 'core/logger'
require 'core/server'

module Core

    class Bot
        attr_reader :servers
        attr_reader :logger 
        attr_reader :worker_instances

        attr_reader :incoming
        attr_reader :outging


        attr_reader :debug

        def initialize(&block)

            @logger     = Logger.new(@debug)
            @debug      = false
            @incoming   = Queue.new
            @outgoing   = Queue.new
            @worker_instances = 5 
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
            s = Core::Server.new(self, name, @default_username, &block)
            @servers[name] = s
            @logger.debug("Server #{name} (#{s.addr}:#{s.port}) added...")
        end

        def start

            workers = spawn_workers


            @servers.each do |_, server|
                server.connect
            end

            while 1;
                sleep 1
            end
            
            workers.map(&:join) 

        end


        def run
            

        end

        private
        def spawn_workers
            @worker_instances.times.map do |i|
                @logger.debug("Spawned ##{i} queue worker..")
                Thread.new do 
                    @logger.debug("Worker ##{i} ready...")
                    while message = @incoming.pop
                        @logger.log(:normal, message.raw, message.time) 
                    end
                    @logger.debug("Worker ##{i} stopped...")

                end
            end
        end
    end
end
