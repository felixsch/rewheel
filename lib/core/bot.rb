require 'thread'
require 'ostruct'

require 'core/logger'
require 'core/server'
require 'core/action'

require 'util/concurrent'

module Core

    ##
    # Basic IRC Bot instance. Before bot can be started with Bot.start
    # configuration is needed.
    #
    # Example:
    #
    #   bot = Core::Bot.new do
    #     set_logger Logger::TTY.new
    #     set_worksers 2
    #     
    #     add_server :freenode do |s|
    #       s.addr = "irc.freenode.net"
    #       s.port = 6667
    #       s.nick = "rewheel-test-bot"
    #       s.user = "Rewheel Test Bot"
    #       s.channels = ["#rewheel-testing"]
    #
    #     
    #     on /!hi/ do
    #       say "Hi #{@user}
    #     end
    #
    #     onlyOn :freenode /!foo/ do
    #       me "bar"
    #     end
    #
    #     on /!quit/ do
    #       @server.quit
    #     end
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
            sym = name.to_s.to_sym
            s = Core::Server.new(self, sym, &block)
            @servers[sym] = s
            @actions[sym] = []
            @logger.debug("Server #{name} (#{s.addr}:#{s.port}) added...")
        end


        def add_incoming(message)
            @incoming.push(message)
        end


        def onlyOn(server, regex, &block)
            @logger.debug("registering onlyOn #{server} #{regex.to_s}")
            sym = server.to_s.to_sym
            @actions[sym].push(
                OpenStruct.new(:regex => regex,
                               :action => block,
                               :cond   => :only_msg))
        end


        def onNum(num, &block)
            @actions[:all].push(
                OpenStruct.new(:action => block,
                               :cond   => :only_num,
                               :num    => num))
        end


        def on(regex, &block)
            @logger.debug("registering on #{regex.to_s}")
            @actions[:all].push(
                OpenStruct.new(:regex  => regex,
                               :action => block,
                               :cond   => :only_msg))
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


        def quit
            @quit = 1
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


        def handle_actions(msg)

            matchers = @actions[:all].dup
            matchers.push(*@actions[msg.server.to_sym])

            if msg.is_numeric?
                matchers = matchers.select do |m|
                    m.cond == :only_num  &&
                    m.num  == msg.command.to_i
                end 
            else
                matchers = matchers.select do |m|
                    m.cond   == :only_msg &&
                    msg.command == "PRIVMSG" &&
                    msg.text =~ m.regex
                end
            end

            # run the actions
            matchers.each do |matcher|
                server = @servers[msg.server.to_sym]
                action = Core::Action.new(msg, server)
                action.run(&matcher.action)
            end 
        end
    end
end
