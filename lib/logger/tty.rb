
require 'time'
require 'core/logger'


module Logger

    class TTY < Core::Logger
     Colors = {
        :reset => "\e[0m",
        :bold => "\e[1m",
        :red => "\e[31m",
        :green => "\e[32m",
        :yellow => "\e[33m",
        :blue => "\e[34m",
        :black => "\e[30m",
      }

        def log(level, msg, time=Time.now)
            
            prefix = case level
                       when :debug then Colors[:bold]
                       when :warn  then Colors[:yellow]
                       when :fatal then Colors[:bold] + Colors[:red]
                       when :error then Colors[:red]
                       when :success then Colors[:green]
                       else ""
                       end
            puts time.strftime("[%Y/%m/%d %H:%M:%S.%L] ") + prefix + msg + Colors[:reset] + "\n"
        end
    end
end
