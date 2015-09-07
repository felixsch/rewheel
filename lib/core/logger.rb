
require 'time'

module Core
    class Logger

        def initialize(debug) 
            @debug = debug == :debug_enable ? true : false
        end
 
        def open; end
        def close; end

        def log(level, msg, time=Time.now); end

        def say(msg)
            log(:normal, msg)
        end

        def success(msg)
            log(:success, msg)
        end

        def warn(msg)
            log(:warn, msg)
        end

        def fatal(msg)
            log(:fatal, msg)
        end

        def debug(msg)
            log(:debug, msg)
        end

        def show_debug_messages?
            @debug
        end

    end
end
