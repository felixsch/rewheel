require "core/message.rb"
require "test/unit"


class TestMessage < Test::Unit::TestCase


    def test_channel_message
        raw = ":fusername!fschnizlei@nat/novell/x-mywvfo PRIVMSG #felixsch :asdkasd\r\n"
        msg = Core::Message.new(raw, nil)

        assert_equal(msg.origin, "fusername!fschnizlei@nat/novell/x-mywvfo")
        assert_equal(msg.command, "PRIVMSG")
        assert_equal(msg.channel, "#felixsch")
        assert_equal(msg.is_ping?, false)
        assert_equal(msg.is_numeric?, false) 
    end

    def test_mode_change
        raw = ":rewheel__ MODE rewheel__ :+i\r\n"
        msg = Core::Message.new(raw, nil)

        assert_equal(msg.origin, "rewheel__")
        assert_equal(msg.command, "MODE")
        assert_equal(msg.text, "+i")
        assert_equal(msg.is_ping?, false)
        assert_equal(msg.is_numeric?, false) 

    end

    def test_numeric_message
        raw = ":leguin.freenode.net 372 rewheel__ :- of this server, details of wh\r\n"
        msg = Core::Message.new(raw, nil)

        assert_equal(msg.origin, "leguin.freenode.net")
        assert_equal(msg.command, "372")
        assert_equal(msg.text, "- of this server, details of wh")
        assert_equal(msg.is_ping?, false)
        assert_equal(msg.is_numeric?, true) 

    end

    def test_ping
        raw = "PING :sendak.freenode.net\r\n"
        msg = Core::Message.new(raw, nil)

        assert_equal(msg.origin, nil)
        assert_equal(msg.command, "PING")
        assert_equal(msg.text, "sendak.freenode.net")
        assert_equal(msg.is_ping?, true)
        assert_equal(msg.is_numeric?, false) 

    end

    def test_notice
        raw = "NOTICE AUTH :*** Looking up your hostname\r\n"
        msg = Core::Message.new(raw, nil)

        assert_equal(msg.origin, nil)
        assert_equal(msg.command, "NOTICE")
        assert_equal(msg.text, "*** Looking up your hostname")
        assert_equal(msg.is_ping?, false)
        assert_equal(msg.is_numeric?, false) 
    end

end
