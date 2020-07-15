# frozen_string_literal: true

if ENV['TEST_LOCAL_INTEGRATION']

  require "spec_helper"

  describe "creating a doc" do
    let(:system_name) { "enroll" }
    let(:signing_secret) { "ABCDEFG" }
    let(:user_id) { "a_user" }

    let(:client) do
      CartafactRb::Client.new(
        "http://localhost:3000",
        system_name,
        signing_secret
      )
    end

    let(:create_resource) do
      CartafactRb::Resources::Create.new(
        "A Document",
        "A doc type",
        subjects: subjects,
        format: "text/plain"
      )
    end

    let(:subjects) do
      []
    end

    it "creates successfully" do
      result = client.create(user_id, [], create_resource, File.open(__FILE__))
      expect(result.id).not_to eq nil
    end
  end

end
