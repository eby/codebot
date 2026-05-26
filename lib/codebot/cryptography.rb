# frozen_string_literal: true

require 'openssl'
require 'securerandom'

module Codebot
  # This module provides convenience methods for performing cryptographic
  # operations.
  module Cryptography
    # Generates a random name for an integration endpoint.
    #
    # @return [String] the generated name
    def self.generate_endpoint
      SecureRandom.uuid
    end

    # Generates a random webhook secret.
    #
    # @return [String] the generated secret
    def self.generate_secret(len = nil)
      SecureRandom.base64(len || 32)
    end

    # Verifies a webhook signature.
    #
    # Accepts either SHA-256 (X-Hub-Signature-256) or SHA-1
    # (X-Hub-Signature) signatures. SHA-256 is preferred.
    #
    # @param body [String] the webhook body
    # @param secret [String] the correct secret
    # @param signature [String] the signature to verify
    # @return [Boolean] whether the signature is correct
    def self.valid_signature?(body, secret, signature)
      return false if signature.nil?

      algo = signature.start_with?('sha256=') ? 'sha256' : 'sha1'
      digest = OpenSSL::Digest.new algo
      good_signature = "#{algo}=" + OpenSSL::HMAC.hexdigest(digest, secret, body)
      Rack::Utils.secure_compare good_signature, signature
    end
  end
end
