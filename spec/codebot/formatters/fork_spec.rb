# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Fork do
  describe '.format' do
    it 'formats a fork event' do
      result = do_format_test('github_fork_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] monalisa created fork monalisa/Hello-World: shortened://https://github.com/monalisa/Hello-World'
    end
  end
end
