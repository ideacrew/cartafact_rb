# frozen_string_literal: true

require "spec_helper"
require "json"

describe CartafactRb::Authorization::Assertion, "given:
- a system name
- a user id
- a single authorized subject
" do
  let(:system_name) { "A CLIENT SYSTEM" }
  let(:user_id) { "A USER ID" }
  let(:authorized_subjects) { [authorized_subject] }

  let(:authorized_subject) do
    CartafactRb::Authorization::AuthorizedSubject.new(
      "subject_type",
      "subject_id"
    )
  end

  let(:subject) do
    CartafactRb::Authorization::Assertion.new(
      system_name,
      user_id,
      authorized_subjects
    )
  end

  describe "and asked to sign an http request" do
    let(:signing_secret) { "ABCDEFGHIJKL" }
    let(:request) do
      double(
        headers: headers
      )
    end

    let(:headers) { Hash.new }

    let(:expected_encoded_assertion) do
      json_value = JSON.dump(
        {
          authorized_identity: {
            system: system_name,
            user_id: user_id
          },
          authorized_subjects: authorized_subjects.map(&:as_json)
        }
      )
      Base64.encode64(json_value)
    end

    let(:expected_assertion_signature) do
      Base64.encode64(
        OpenSSL::HMAC.digest("SHA256", signing_secret, expected_encoded_assertion)
      )
    end

    it "sets the assertion value header" do
      subject.encode_and_sign_to_http_request(
        request,
        signing_secret
      )
      expect(request.headers["X-RequestingIdentity"]).to eq expected_encoded_assertion
    end

    it "sets the assertion signature header" do
      subject.encode_and_sign_to_http_request(
        request,
        signing_secret
      )
      expect(request.headers["X-RequestingIdentitySignature"]).to eq expected_assertion_signature
    end
  end
end
