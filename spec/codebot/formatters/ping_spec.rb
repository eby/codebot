# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Ping do
  describe '.format' do
    it 'formats a repository webhook ping' do
      result = do_format_test('github_ping_repo', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[octocat/Hello-World] octocat added a webhook for the pull_request and push events: shortened://https://github.com/octocat/Hello-World'
    end

    it 'formats an organization webhook ping for all events' do
      result = do_format_test('github_ping_org', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[github] octocat added a webhook for all events: shortened://https://github.com/github'
    end
  end
end
