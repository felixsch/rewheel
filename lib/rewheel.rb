#!/usr/bin/env ruby

require 'core/bot'
require 'logger/tty'

#module Test
#   def enable_x
#      puts "Enabled x\n" 
#   end
#
#   def start
#      puts "Hooked start\n"
#      super
#   end
#end
#
#class MyBot < Core::Bot
#   include Test
#
#   def start
#      puts "Fooo\n"
#      super
#   end
# 
#   # include Data::Database
#
#   # include Data::UserAuth
#   # include Data::ChannelLogging
#   # include Data::MemoServ
#
#   # include Fun::CatResolver
#end

class Rewheel

   def run

      bot = Core::Bot.new do 

         set_workers 5
         set_logger Logger::TTY.new(:enable_debug)

         add_server :freenode do |s|
            s.addr = "irc.freenode.net"
            s.port = 6667
            s.nick = "rewheel__"
            s.channels = ["#felixsch"]
         end

         #add_server :quakenet do |s|
         #   s.addr = "irc.quakenet.org"
         #   s.port = 6667
         #   s.nick = "rewheel__"
         #   s.channels = ["#felixsch"]
         #end

         on /!echo/ do
            say "You said #{@message.text}"
         end

         onlyOn :freenode, /cat/ do
            say "I love kitten, I wanna hugh them all!"
         end
      end

      bot.start

   end



end

