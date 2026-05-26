# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Watch do
  describe '.format' do
    it 'formats a watch (star) event' do
      result = do_format_test('github_watch_started', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat starred the repository: shortened://https://github.com/octocat/Hello-World/stargazers'
    end

    it 'returns nil for non-started actions' do
      formatter = load_formatter_from('github_watch_other', described_class)
      expect(formatter.format).to be_nil
    end
  end
end
