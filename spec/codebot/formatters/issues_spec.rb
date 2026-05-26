# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Issues do
  describe '.format' do
    it 'formats an opened issue' do
      result = do_format_test('github_issues_opened', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat opened issue #7: Found a bug: shortened://https://github.com/octocat/Hello-World/issues/7'
    end

    it 'formats a closed issue' do
      result = do_format_test('github_issues_closed', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat closed issue #7: Found a bug: shortened://https://github.com/octocat/Hello-World/issues/7'
    end

    it 'returns nil for unhandled actions' do
      formatter = load_formatter_from('github_issues_labeled', described_class)
      expect(formatter.format).to be_nil
    end
  end
end
