
# line 1 "message.rl"
# simple_state_machine.rl

# line 50 "message.rl"


module Core
  class Message

    class InvalidMessage < RuntimeError; end

    attr_reader :raw

    attr_reader :origin
    attr_reader :command
    attr_reader :text
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
	3, 1, 5, 1, 7, 1, 8, 1, 
	9, 2, 0, 3, 2, 5, 3, 3, 
	4, 6, 5
]

class << self
	attr_accessor :_irc_message_key_offsets
	private :_irc_message_key_offsets, :_irc_message_key_offsets=
end
self._irc_message_key_offsets = [
	0, 0, 9, 11, 13, 15, 16, 25, 
	31, 37, 43, 55, 57, 69, 71, 73, 
	86, 102, 109, 115, 120, 127, 133, 140, 
	149, 157, 164, 171, 178, 185, 191, 200, 
	214, 227, 240, 242, 254, 256, 258, 259, 
	266, 273, 280, 286, 295, 309, 322, 323
]

class << self
	attr_accessor :_irc_message_trans_keys
	private :_irc_message_trans_keys, :_irc_message_trans_keys=
end
self._irc_message_trans_keys = [
	58, 69, 80, 48, 57, 65, 90, 97, 
	122, 48, 57, 48, 57, 13, 32, 10, 
	32, 35, 58, 1, 9, 11, 12, 14, 
	127, 13, 32, 1, 9, 11, 127, 13, 
	32, 1, 9, 11, 127, 13, 32, 1, 
	9, 11, 127, 10, 13, -128, -63, -62, 
	-33, -32, -17, -16, -12, -11, 0, -128, 
	-65, 10, 13, -128, -63, -62, -33, -32, 
	-17, -16, -12, -11, 0, -128, -65, -128, 
	-65, 45, 46, 123, 48, 57, 65, 90, 
	91, 96, 97, 122, 125, 126, 32, 33, 
	45, 46, 64, 123, 48, 57, 65, 90, 
	91, 96, 97, 122, 125, 126, 32, 48, 
	57, 65, 90, 97, 122, 13, 32, 65, 
	90, 97, 122, 45, 65, 123, 125, 126, 
	32, 45, 64, 65, 123, 125, 126, 45, 
	57, 65, 90, 97, 122, 32, 45, 57, 
	65, 90, 97, 122, 32, 45, 46, 48, 
	57, 65, 90, 97, 122, 32, 33, 45, 
	64, 65, 123, 125, 126, 13, 32, 82, 
	65, 90, 97, 122, 13, 32, 82, 65, 
	90, 97, 122, 13, 32, 79, 65, 90, 
	97, 122, 13, 32, 82, 65, 90, 97, 
	122, 13, 32, 65, 90, 97, 122, 32, 
	35, 58, 1, 9, 11, 12, 14, 127, 
	10, 13, 32, 58, -128, -63, -62, -33, 
	-32, -17, -16, -12, -11, 0, 10, 13, 
	32, -128, -63, -62, -33, -32, -17, -16, 
	-12, -11, 0, 10, 13, 32, -128, -63, 
	-62, -33, -32, -17, -16, -12, -11, 0, 
	-128, -65, 10, 13, -128, -63, -62, -33, 
	-32, -17, -16, -12, -11, 0, -128, -65, 
	-128, -65, 10, 13, 32, 73, 65, 90, 
	97, 122, 13, 32, 78, 65, 90, 97, 
	122, 13, 32, 71, 65, 90, 97, 122, 
	13, 32, 65, 90, 97, 122, 32, 35, 
	58, 1, 9, 11, 12, 14, 127, 10, 
	13, 32, 58, -128, -63, -62, -33, -32, 
	-17, -16, -12, -11, 0, 10, 13, 32, 
	-128, -63, -62, -33, -32, -17, -16, -12, 
	-11, 0, 10, 0
]

class << self
	attr_accessor :_irc_message_single_lengths
	private :_irc_message_single_lengths, :_irc_message_single_lengths=
end
self._irc_message_single_lengths = [
	0, 3, 0, 0, 2, 1, 3, 2, 
	2, 2, 2, 0, 2, 0, 0, 3, 
	6, 1, 2, 1, 3, 0, 1, 1, 
	4, 3, 3, 3, 3, 2, 3, 4, 
	3, 3, 0, 2, 0, 0, 1, 3, 
	3, 3, 2, 3, 4, 3, 1, 0
]

class << self
	attr_accessor :_irc_message_range_lengths
	private :_irc_message_range_lengths, :_irc_message_range_lengths=
end
self._irc_message_range_lengths = [
	0, 3, 1, 1, 0, 0, 3, 2, 
	2, 2, 5, 1, 5, 1, 1, 5, 
	5, 3, 2, 2, 2, 3, 3, 4, 
	2, 2, 2, 2, 2, 2, 3, 5, 
	5, 5, 1, 5, 1, 1, 0, 2, 
	2, 2, 2, 3, 5, 5, 0, 0
]

class << self
	attr_accessor :_irc_message_index_offsets
	private :_irc_message_index_offsets, :_irc_message_index_offsets=
end
self._irc_message_index_offsets = [
	0, 0, 7, 9, 11, 14, 16, 23, 
	28, 33, 38, 46, 48, 56, 58, 60, 
	69, 81, 86, 91, 95, 101, 105, 110, 
	116, 123, 129, 135, 141, 147, 152, 159, 
	169, 178, 187, 189, 197, 199, 201, 203, 
	209, 215, 221, 226, 233, 243, 252, 254
]

class << self
	attr_accessor :_irc_message_indicies
	private :_irc_message_indicies, :_irc_message_indicies=
end
self._irc_message_indicies = [
	2, 4, 5, 0, 3, 3, 1, 6, 
	1, 7, 1, 8, 9, 1, 10, 1, 
	12, 13, 14, 11, 11, 11, 1, 16, 
	17, 15, 15, 1, 16, 17, 18, 18, 
	1, 19, 20, 18, 18, 1, 1, 25, 
	1, 21, 22, 23, 1, 24, 26, 1, 
	1, 30, 1, 27, 28, 29, 1, 26, 
	27, 1, 28, 1, 31, 32, 33, 32, 
	31, 33, 31, 33, 1, 34, 35, 36, 
	37, 38, 39, 37, 36, 39, 36, 39, 
	1, 40, 0, 3, 3, 1, 8, 9, 
	41, 41, 1, 42, 42, 42, 1, 34, 
	42, 38, 42, 42, 1, 43, 43, 43, 
	1, 34, 43, 43, 43, 1, 34, 37, 
	37, 37, 37, 1, 34, 35, 39, 38, 
	39, 39, 1, 8, 9, 44, 41, 41, 
	1, 8, 9, 45, 41, 41, 1, 8, 
	9, 46, 41, 41, 1, 8, 9, 47, 
	41, 41, 1, 8, 48, 41, 41, 1, 
	12, 13, 49, 11, 11, 11, 1, 1, 
	25, 24, 24, 1, 21, 22, 23, 1, 
	50, 1, 30, 52, 1, 27, 28, 29, 
	1, 51, 1, 57, 58, 1, 53, 54, 
	55, 1, 56, 59, 1, 1, 63, 1, 
	60, 61, 62, 1, 59, 60, 1, 61, 
	1, 64, 1, 8, 9, 65, 41, 41, 
	1, 8, 9, 66, 41, 41, 1, 8, 
	9, 67, 41, 41, 1, 8, 68, 41, 
	41, 1, 12, 13, 69, 11, 11, 11, 
	1, 1, 25, 24, 24, 1, 21, 22, 
	23, 1, 70, 1, 72, 26, 1, 27, 
	28, 29, 1, 71, 73, 1, 1, 0
]

class << self
	attr_accessor :_irc_message_trans_targs
	private :_irc_message_trans_targs, :_irc_message_trans_targs=
end
self._irc_message_trans_targs = [
	2, 0, 15, 18, 25, 39, 3, 4, 
	5, 6, 47, 7, 6, 8, 10, 7, 
	5, 6, 9, 5, 6, 11, 13, 14, 
	12, 5, 12, 11, 13, 14, 5, 16, 
	23, 24, 17, 19, 16, 23, 21, 24, 
	17, 18, 20, 22, 26, 27, 28, 29, 
	30, 31, 32, 32, 33, 34, 36, 37, 
	35, 38, 33, 35, 34, 36, 37, 38, 
	47, 40, 41, 42, 43, 44, 45, 45, 
	46, 47
]

class << self
	attr_accessor :_irc_message_trans_actions
	private :_irc_message_trans_actions, :_irc_message_trans_actions=
end
self._irc_message_trans_actions = [
	1, 0, 0, 1, 1, 1, 0, 13, 
	5, 5, 0, 1, 0, 1, 0, 0, 
	9, 9, 0, 23, 23, 1, 1, 1, 
	1, 17, 0, 0, 0, 0, 7, 1, 
	1, 1, 3, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	5, 0, 1, 0, 9, 1, 1, 1, 
	1, 17, 1, 0, 0, 0, 0, 7, 
	15, 0, 0, 0, 5, 0, 1, 0, 
	20, 11
]

class << self
	attr_accessor :irc_message_start
end
self.irc_message_start = 1;
class << self
	attr_accessor :irc_message_first_final
end
self.irc_message_first_final = 47;
class << self
	attr_accessor :irc_message_error
end
self.irc_message_error = 0;

class << self
	attr_accessor :irc_message_en_main
end
self.irc_message_en_main = 1;


# line 71 "message.rl"

      raise InvalidMessage if msg.empty?

      @raw    = msg
      @server = server

      @origin, @command, @text, @channel = nil, nil, nil, nil
      @is_ping, @is_error, @is_numeric, @has_channel = false, false, false, false

      @params = []

      parse
    end

    def parse
      data = @raw.unpack("c*")

      
# line 251 "message.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = irc_message_start
end

# line 89 "message.rl"
      
# line 260 "message.rb"
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
 @text    = data[idx..(p-1)].pack("c*") 		end
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
when 9 then
# line 14 "message.rl"
		begin
 @is_error    = true 		end
# line 381 "message.rb"
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

# line 90 "message.rl"

      raise InvalidMessage if (p != pe) # check if end state is successfully final state
    end

    def is_ping?
      @is_ping
    end

    def is_error?
      @is_error
    end

    def is_numeric?
      @is_numeric
    end

    def has_channel?
      @has_channel
    end
  end
end
