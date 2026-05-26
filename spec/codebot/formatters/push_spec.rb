# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Push do
  describe '.format' do
    it 'formats a regular push with multiple commits' do
      result = do_format_test('github_push_1', described_class)
      expect(result.length).to eq 3
      expect(result[0]).to eq '[Hello-World] octocat pushed 2 new commits to master: shortened://https://github.com/octocat/Hello-World/compare/6dcb09b...85e7e30'
      expect(result[1]).to eq 'Hello-World/master 6dcb09b octocat: Fix all the bugs'
      expect(result[2]).to eq 'Hello-World/master 85e7e30 monalisa: Add new feature'
    end

    it 'formats a force push' do
      result = do_format_test('github_push_force', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat force-pushed feature from 6dcb09b to 85e7e30: shortened://https://github.com/octocat/Hello-World/commits/feature'
    end

    it 'formats a branch creation' do
      result = do_format_test('github_push_create_branch', described_class)
      expect(result.length).to eq 2
      expect(result[0]).to eq '[Hello-World] octocat created new-feature at 85e7e30 (+1 new commit): shortened://https://github.com/octocat/Hello-World/compare/85e7e30c96750e6f89e6b2df5da5e8fcb5e77d3a'
      expect(result[1]).to eq 'Hello-World/new-feature 85e7e30 octocat: Initial commit for new feature'
    end

    it 'formats a branch deletion' do
      result = do_format_test('github_push_delete_branch', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat deleted old-branch at 6dcb09b: shortened://https://github.com/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e'
    end

    it 'formats a tag creation' do
      result = do_format_test('github_push_tag', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat tagged v1.0.0 at 85e7e30: shortened://https://github.com/octocat/Hello-World/commits/v1.0.0'
    end
  end
end
