require 'cinch'
require File.expand_path('../lib/topical_plugin')

class RubyMidwest
	include Cinch::Plugin
	include TopicalPlugin

	keyword 'conf'

	topic 'schedule' do |m|
		m.reply('Online Schedule: http://lanyrd.com/2011/ruby-midwest/schedule/')
	end

	topic 'map' do |m|
		m.reply('Conference Google Map: http://g.co/maps/b42bj')
	end
end
