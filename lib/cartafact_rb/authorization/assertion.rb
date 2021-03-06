# frozen_string_literal: true

require "base64"
require "json"
require "openssl"

module CartafactRb
  module Authorization
    # An assertion represents a claim by the requesting system that access to a document is allowed.
    class Assertion
      ASSERTION_HEADER_NAME = "X-RequestingIdentity"
      SIGNATURE_HEADER_NAME = "X-RequestingIdentitySignature"

      # Create a new assertion.
      # @param s_name [String] The name of the system making the request.
      # @param user_id [String] The ID or Email of the user making the request.
      # @param authorized_subjects [Array<CartafactRb::Authorization::AuthorizedSubject>]
      #   The authorized subjects for the request.
      def initialize(s_name, user_id, authorized_subjects)
        @system_name = s_name
        @user_id = user_id
        @subjects = authorized_subjects
      end

      # Encode the assertion into a request, including the signature.
      # @param request [Faraday::Request]
      # @param signing_secret [String]
      # @return [Void]
      def encode_and_sign_to_http_request(request, signing_secret)
        authorization_info_b64 = Base64.strict_encode64(as_json)
        request.headers[ASSERTION_HEADER_NAME] = authorization_info_b64
        signature = OpenSSL::HMAC.digest("SHA256", signing_secret, authorization_info_b64)
        request.headers[SIGNATURE_HEADER_NAME] = Base64.strict_encode64(signature)
      end

      def as_json
        JSON.dump(
          {
            authorized_identity: {
              system: @system_name,
              user_id: @user_id
            },
            authorized_subjects: @subjects.map(&:as_json)
          }
        )
      end
    end
  end
end
