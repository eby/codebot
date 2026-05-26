# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::IssueComment do
  describe '.format' do
    it 'formats an issue comment' do
      result = do_format_test('github_issue_comment_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat commented on issue #7: This is a great comment: shortened://https://github.com/octocat/Hello-World/issues/7#issuecomment-1'
    end
  end
end
