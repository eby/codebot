# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::CommitComment do
  describe '.format' do
    it 'formats a commit comment' do
      result = do_format_test('github_commit_comment_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat commented on commit 6dcb09b: Looks good to me: shortened://https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e#commitcomment-1'
    end
  end
end
