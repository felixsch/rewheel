# simple_state_machine.rl
%%{
    machine irc_message;

    action set_idx     { idx = p }
    action set_origin  { @origin  = data[idx..(p-1)].pack("c*") }
    action set_cmd     { @command = data[idx..(p-1)].pack("c*") }
    action set_msg     { @message = data[idx..(p-1)].pack("c*") } 
    action set_channel { @channel = data[idx..(p-1)].pack("c*") }
    action set_param   { @params << data[idx..(p-1)].pack("c*") }
    action has_channel { @has_channel = true }
    action is_ping     { @is_ping     = true }
    action is_numeric  { @is_numeric  = true }


    cr             = '\r';
    lf             = '\n';
    ws             = ' '+;
    nows           = ascii -- (ws | '\0' | cr | lf);
    allowedSpecial = ('_' | '-' | '[' | ']' | '\\' | '`' | '^' | '{' | '}' | '~');

    # shameless plug from http://bit.ly/1XG3Xrz
    # matches any valid utf encoded character
    unicode = (0x01..0x1f | 0x7f)
            | (0xc2..0xdf 0x80..0xbf)
            | (0xe0..0xef 0x80..0xbf 0x80..0xbf)
            | (0xf0..0xf4 0x80..0xbf 0x80..0xbf 0x80..0xbf);


    host     = (alpha | digit | '-' | '.')+;
    name     = (alpha | allowedSpecial)+; 
    username = '!' name+;
    userhost = '@' (alpha | digit | '-' | '.' | '/')+;

    origin   = (host | name username? userhost?)        > set_idx % set_origin;
    ncommand = digit digit digit                        > is_numeric;
    command  = (alpha+ | ncommand)                      > set_idx % set_cmd;

    channel  = ('#' nows+)                              > set_idx % set_channel % has_channel;
    param    = ((nows - ':') nows* )                    > set_idx % set_param;
    msg      = ((ascii | unicode) -- ('\0' | cr | lf))* > set_idx % set_msg;
    params   = (ws channel | ws param)* (ws ':' msg)?;

    message  = ':' origin ws command params cr lf;
    ping     = "PING :" host                            > is_ping;

    main := ping | message;
}%%

module Core
  class Message

    class InvalidMessage < RuntimeError; end

    attr_reader :raw

    attr_reader :origin
    attr_reader :command
    attr_reader :message
    attr_reader :channel

    attr_reader :params

    attr_reader :server

    def initialize(msg, server)

      %% write data;

      raise InvalidMessage if msg.empty?

      @raw    = msg
      @server = server

      @origin, @command, @message, @channel = nil, nil, nil, nil
      @is_ping, @is_numeric, @has_channel = false, false

      @params = []

      parse
    end

    def parse
      data = @raw.unpack("c*")

      %% write init;
      %% write exec;

      raise InvalidMessage if (p != pe) # check if end state is successfully final state
    end

    def is_ping?
      @is_ping
    end

    def is_numeric?
      @is_numeric
    end

    def has_channel?
      @has_channel
    end
  end
end
