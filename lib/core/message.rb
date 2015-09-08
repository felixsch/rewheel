
# line 1 "message.rl"
# simple_state_machine.rl

# line 48 "message.rl"


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

      
# line 28 "message.rb"
class << self
	attr_accessor :_irc_message_actions
	private :_irc_message_actions, :_irc_message_actions=
end
self._irc_message_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 5, 1, 7, 1, 8, 2, 
	0, 3, 3, 4, 6, 5
]

class << self
	attr_accessor :_irc_message_key_offsets
	private :_irc_message_key_offsets, :_irc_message_key_offsets=
end
self._irc_message_key_offsets = [
	0, 0, 2, 15, 31, 38, 40, 42, 
	44, 45, 54, 60, 66, 72, 84, 86, 
	98, 100, 102, 108, 113, 120, 126, 133, 
	142, 150, 151, 152, 153, 154, 155, 163, 
	163
]

class << self
	attr_accessor :_irc_message_trans_keys
	private :_irc_message_trans_keys, :_irc_message_trans_keys=
end
self._irc_message_trans_keys = [
	58, 80, 45, 46, 123, 48, 57, 65, 
	90, 91, 96, 97, 122, 125, 126, 32, 
	33, 45, 46, 64, 123, 48, 57, 65, 
	90, 91, 96, 97, 122, 125, 126, 32, 
	48, 57, 65, 90, 97, 122, 48, 57, 
	48, 57, 13, 32, 10, 32, 35, 58, 
	1, 9, 11, 12, 14, 127, 13, 32, 
	1, 9, 11, 127, 13, 32, 1, 9, 
	11, 127, 13, 32, 1, 9, 11, 127, 
	10, 13, -128, -63, -62, -33, -32, -17, 
	-16, -12, -11, 0, -128, -65, 10, 13, 
	-128, -63, -62, -33, -32, -17, -16, -12, 
	-11, 0, -128, -65, -128, -65, 13, 32, 
	65, 90, 97, 122, 45, 65, 123, 125, 
	126, 32, 45, 64, 65, 123, 125, 126, 
	45, 57, 65, 90, 97, 122, 32, 45, 
	57, 65, 90, 97, 122, 32, 45, 46, 
	48, 57, 65, 90, 97, 122, 32, 33, 
	45, 64, 65, 123, 125, 126, 73, 78, 
	71, 32, 58, 45, 46, 48, 57, 65, 
	90, 97, 122, 45, 46, 48, 57, 65, 
	90, 97, 122, 0
]

class << self
	attr_accessor :_irc_message_single_lengths
	private :_irc_message_single_lengths, :_irc_message_single_lengths=
end
self._irc_message_single_lengths = [
	0, 2, 3, 6, 1, 0, 0, 2, 
	1, 3, 2, 2, 2, 2, 0, 2, 
	0, 0, 2, 1, 3, 0, 1, 1, 
	4, 1, 1, 1, 1, 1, 0, 0, 
	0
]

class << self
	attr_accessor :_irc_message_range_lengths
	private :_irc_message_range_lengths, :_irc_message_range_lengths=
end
self._irc_message_range_lengths = [
	0, 0, 5, 5, 3, 1, 1, 0, 
	0, 3, 2, 2, 2, 5, 1, 5, 
	1, 1, 2, 2, 2, 3, 3, 4, 
	2, 0, 0, 0, 0, 0, 4, 0, 
	4
]

class << self
	attr_accessor :_irc_message_index_offsets
	private :_irc_message_index_offsets, :_irc_message_index_offsets=
end
self._irc_message_index_offsets = [
	0, 0, 3, 12, 24, 29, 31, 33, 
	36, 38, 45, 50, 55, 60, 68, 70, 
	78, 80, 82, 87, 91, 97, 101, 106, 
	112, 119, 121, 123, 125, 127, 129, 134, 
	135
]

class << self
	attr_accessor :_irc_message_indicies
	private :_irc_message_indicies, :_irc_message_indicies=
end
self._irc_message_indicies = [
	0, 2, 1, 3, 4, 5, 4, 3, 
	5, 3, 5, 1, 6, 7, 8, 9, 
	10, 11, 9, 8, 11, 8, 11, 1, 
	12, 13, 14, 14, 1, 15, 1, 16, 
	1, 17, 18, 1, 19, 1, 21, 22, 
	23, 20, 20, 20, 1, 25, 26, 24, 
	24, 1, 25, 26, 27, 27, 1, 28, 
	29, 27, 27, 1, 1, 34, 1, 30, 
	31, 32, 1, 33, 35, 1, 1, 39, 
	1, 36, 37, 38, 1, 35, 36, 1, 
	37, 1, 17, 18, 40, 40, 1, 41, 
	41, 41, 1, 6, 41, 10, 41, 41, 
	1, 42, 42, 42, 1, 6, 42, 42, 
	42, 1, 6, 9, 9, 9, 9, 1, 
	6, 7, 11, 10, 11, 11, 1, 43, 
	1, 44, 1, 45, 1, 46, 1, 47, 
	1, 48, 48, 48, 48, 1, 1, 49, 
	49, 49, 49, 1, 0
]

class << self
	attr_accessor :_irc_message_trans_targs
	private :_irc_message_trans_targs, :_irc_message_trans_targs=
end
self._irc_message_trans_targs = [
	2, 0, 25, 3, 23, 24, 4, 19, 
	3, 23, 21, 24, 4, 5, 18, 6, 
	7, 8, 9, 31, 10, 9, 11, 13, 
	10, 8, 9, 12, 8, 9, 14, 16, 
	17, 15, 8, 15, 14, 16, 17, 8, 
	18, 20, 22, 26, 27, 28, 29, 30, 
	32, 32
]

class << self
	attr_accessor :_irc_message_trans_actions
	private :_irc_message_trans_actions, :_irc_message_trans_actions=
end
self._irc_message_trans_actions = [
	0, 0, 0, 1, 1, 1, 3, 0, 
	0, 0, 0, 0, 0, 1, 1, 0, 
	13, 5, 5, 0, 1, 0, 1, 0, 
	0, 9, 9, 0, 18, 18, 1, 1, 
	1, 1, 15, 0, 0, 0, 0, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	11, 0
]

class << self
	attr_accessor :irc_message_start
end
self.irc_message_start = 1;
class << self
	attr_accessor :irc_message_first_final
end
self.irc_message_first_final = 31;
class << self
	attr_accessor :irc_message_error
end
self.irc_message_error = 0;

class << self
	attr_accessor :irc_message_en_main
end
self.irc_message_en_main = 1;


# line 69 "message.rl"

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

      
# line 207 "message.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = irc_message_start
end

# line 87 "message.rl"
      
# line 216 "message.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _irc_message_key_offsets[cs]
	_trans = _irc_message_index_offsets[cs]
	_klen = _irc_message_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _irc_message_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _irc_message_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _irc_message_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _irc_message_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _irc_message_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _irc_message_indicies[_trans]
	cs = _irc_message_trans_targs[_trans]
	if _irc_message_trans_actions[_trans] != 0
		_acts = _irc_message_trans_actions[_trans]
		_nacts = _irc_message_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _irc_message_actions[_acts - 1]
when 0 then
# line 5 "message.rl"
		begin
 idx = p 		end
when 1 then
# line 6 "message.rl"
		begin
 @origin  = data[idx..(p-1)].pack("c*") 		end
when 2 then
# line 7 "message.rl"
		begin
 @command = data[idx..(p-1)].pack("c*") 		end
when 3 then
# line 8 "message.rl"
		begin
 @message = data[idx..(p-1)].pack("c*") 		end
when 4 then
# line 9 "message.rl"
		begin
 @channel = data[idx..(p-1)].pack("c*") 		end
when 5 then
# line 10 "message.rl"
		begin
 @params << data[idx..(p-1)].pack("c*") 		end
when 6 then
# line 11 "message.rl"
		begin
 @has_channel = true 		end
when 7 then
# line 12 "message.rl"
		begin
 @is_ping     = true 		end
when 8 then
# line 13 "message.rl"
		begin
 @is_numeric  = true 		end
# line 333 "message.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 88 "message.rl"

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
