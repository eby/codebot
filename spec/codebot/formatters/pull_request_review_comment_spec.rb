# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::PullRequestReviewComment do
  describe '.format' do
    it 'formats a pull request review comment' do
      result = do_format_test('github_pull_request_review_comment_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat commented on pull request #42 6dcb09b: Great change! ...: shortened://https://github.com/octocat/Hello-World/pull/42#discussion_r1'
    end
  end
end
