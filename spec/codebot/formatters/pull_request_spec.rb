# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::PullRequest do
  describe '.format' do
    it 'formats an opened pull request' do
      result = do_format_test('github_pull_request_opened', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] monalisa opened pull request #42: Amazing new feature (master...monalisa:feature-branch): shortened://https://github.com/octocat/Hello-World/pull/42'
    end

    it 'formats a closed pull request' do
      result = do_format_test('github_pull_request_closed', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] monalisa closed pull request #42: Amazing new feature (master...monalisa:feature-branch): shortened://https://github.com/octocat/Hello-World/pull/42'
    end

    it 'returns nil for unhandled actions' do
      formatter = load_formatter_from('github_pull_request_labeled', described_class)
      expect(formatter.format).to be_nil
    end
  end
end
