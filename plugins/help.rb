require 'cinch'
require File.expand_path('../lib/topical_plugin')

class Help
	include Cinch::Plugin
	include TopicalPlugin

	keyword 'help'

	topic 'hack' do |m|
		m.reply 'Add new Cinch plugins to https://github.com/databasically/confbot/plugins'
	end

	topic 'plugins' do |m, plugin|
		m.reply(plugin.bot.plugins.map(&:class).join(', '))
	end

	def plugins
		bot.plugins.map(&:class).join(', ')
	end
end
