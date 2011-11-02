module TopicalPlugin
	class Topic
		attr_reader :name
		def initialize(key, handler)
			@name = key
			@regexp = Regexp.new(key)
			@handler = handler
		end

		def execute(message, topic_value, plugin)
			if topic_value =~ @regexp
				args = [message]
				args << plugin if @handler.arity == 2
				@handler.call(*args)
				return true
			end
			return false
		end
	end

	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods
		def topic(key, &handler)
			topics << Topic.new(key, handler)
		end

		def keyword(value=nil)
			if !@keyword && value
				@keyword = value
				match(Regexp.new("#{value}(\s.+)?"))
			end

			@keyword
		end

		def topics
			@topics ||= []
		end
	end

	def topics
		self.class.topics
	end

	def keyword
		self.class.keyword
	end

	def execute(m, *args)
		success = false
		topics.each do |topic|
			break if (success = topic.execute(m, args.first, self))
		end

		default(m) unless success
	end

	def default(m)
		m.reply("Usage: '#{keyword} [#{topics.map(&:name).sort.join(' | ')}]'")
	end
end
