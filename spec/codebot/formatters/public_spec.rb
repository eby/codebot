# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Public do
  describe '.format' do
    it 'formats a public (open-sourced) event' do
      result = do_format_test('github_public_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat open-sourced the repository: shortened://https://github.com/octocat/Hello-World'
    end
  end
end
