# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Create do
  describe '.format' do
    it 'formats a branch creation' do
      result = do_format_test('github_create_branch', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat created branch my-branch: shortened://https://github.com/octocat/Hello-World'
    end

    it 'produces no message for tag creation' do
      formatter = load_formatter_from('github_create_tag', described_class)
      expect(formatter.format).to be_nil
    end
  end
end
