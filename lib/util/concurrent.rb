module Util
    def wait_until
        loop do
            break if block_given? && yield
            sleep 1
        end
    end
end
