# frozen_string_literal: true

# Compatibility patches for cinch 2.3.4 on Ruby 3.x.
#
# 1. Logger#log: Ruby 3 separated positional Hash args from keyword args.
#    cinch passes an options Hash as a positional arg to String#encode,
#    which Ruby 3 tries to coerce to an encoding name -> TypeError.
#
# 2. Configuration#[]=: OpenStruct#modifiable and #new_ostruct_member were
#    removed in Ruby 3.2. Replace with direct @table assignment.

module Cinch
  class Logger
    def log(messages, event = :debug, level = event)
      return unless will_log?(level)

      @mutex.synchronize do
        Array(messages).each do |message|
          message = format_general(message)
          message = format_message(message, event)

          next if message.nil?

          @output.puts message.to_s.encode('locale', invalid: :replace, undef: :replace)
        end
      end
    end
  end

  class Configuration
    def []=(key, value)
      raise ArgumentError, "Unknown option #{key}" unless self.class::KnownOptions.include?(key)

      @table[key] = value
    end
  end

  module Utilities
    module Encoding
      def self.encode_incoming(string, encoding)
        string = string.dup
        if encoding == :irc
          string.force_encoding("UTF-8")
          unless string.valid_encoding?
            string.force_encoding("CP1252").encode!("UTF-8", invalid: :replace, undef: :replace)
          end
        else
          string.force_encoding(encoding).encode!(invalid: :replace, undef: :replace)
          string = string.chars.select { |c| c.valid_encoding? }.join
        end
        string
      end

      def self.encode_outgoing(string, encoding)
        string = string.dup
        encoding = "UTF-8" if encoding == :irc
        string.encode!(encoding, invalid: :replace, undef: :replace).force_encoding("ASCII-8BIT")
      end
    end
  end
end
