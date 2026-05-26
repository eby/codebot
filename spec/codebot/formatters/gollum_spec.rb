# frozen_string_literal: true

require 'codebot/formatters/gitlab_helpers'

RSpec.describe Codebot::Formatters::Gollum do
  describe '.format' do
    it 'formats a single wiki page event' do
      result = do_format_test('github_gollum_1', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat created wiki page Home: Initial setup: shortened://https://github.com/octocat/Hello-World/wiki/Home'
    end

    it 'formats a multiple wiki page event' do
      result = do_format_test('github_gollum_2', described_class)
      expect(result.length).to eq 1
      expect(result[0]).to eq '[Hello-World] octocat created 1 and edited 1 wiki page: shortened://https://github.com/octocat/Hello-World/wiki'
    end
  end
end
