# frozen_string_literal: true

module Codebot
  module Formatters
    # This class formats create events (branch/tag creation).
    class Create < Formatter
      # Formats IRC messages for a create event.
      # Only branch creations produce a message; tag creations are silent
      # because push events already carry full tag context with commit info.
      #
      # @return [Array<String>, nil] the formatted messages, or nil for tags
      def format
        return unless branch?

        ["#{summary}: #{format_url url}"]
      end

      def summary
        default_format % {
          repository: format_repository(repository_name),
          sender:     format_user(sender_name),
          ref_type:   ref_type,
          ref:        format_branch(ref)
        }
      end

      def default_format
        '[%<repository>s] %<sender>s created %<ref_type>s %<ref>s'
      end

      def ref
        extract(:ref).to_s
      end

      def ref_type
        extract(:ref_type).to_s
      end

      def branch?
        ref_type == 'branch'
      end

      def repository_url
        extract(:repository, :html_url).to_s
      end

      def summary_url
        repository_url
      end
    end
  end
end
