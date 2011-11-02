require 'rubygems'
require 'bundler/setup'

require 'cinch'
require 'active_support'
require 'active_support/core_ext'

plugins_dir = File.expand_path(File.join(File.dirname(__FILE__), 'plugins'))

plugins = []
Dir.chdir(plugins_dir) do 
  Dir['**/*.rb'].each do |plugin_path|
    require File.join(plugins_dir, plugin_path)
    plugins << plugin_path[0..-4].camelize.constantize
  end
end

puts "Loading Plugins... #{plugins.inspect}"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick            = "ConfBot"
    c.server          = "irc.freenode.org"
    c.channels        = ["#cinch-bots"]
    c.plugins.plugins = plugins
  end
end

bot.start
