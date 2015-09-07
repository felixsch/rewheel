module Core

    class Server

       
        attr_reader   :name

        attr_accessor :addr
        attr_accessor :port
        attr_accessor :username
        attr_accessor :password
        attr_accessor :channels

        def initialize(name, username, &block)
            @username = username
            @name = name
            
            if block_given?
                instance_eval(&block)
            end
        end

        def to_s()
            str = "#{@name} — #{@addr}:#{@port}\n"
            str += " '- username = #{@username.join(" ")}\n" if @username
            str += " '- password = #{@password}\n" if @password
            str += " '- channels = #{@channels.join(" ")}\n" if @channels
            return str
        end

    end
end
