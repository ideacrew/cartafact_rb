# frozen_string_literal: true

require 'faraday'

module CartafactRb
  class Client
    LIST_ENDPOINT_PATH = "/api/v1/documents"
    CREATE_ENDPOINT_PATH = "/api/v1/documents"
    SHOW_ENDPOINT_PATH = "/api/v1/documents/"

    attr_reader :endpoint_url
    attr_reader :system_name

    # Create a new client.
    # @param endpoint [String] The base URL for the Cartafact server.
    # @param s_name [String] The name of your system.
    # @param s_secret [String] The signing secret of your system.
    def initialize(endpoint, s_name, s_secret)
      @endpoint_url = endpoint
      @system_name = s_name
      @system_secret = s_secret
      @client = Faraday.new(@endpoint_url) do |conn|
        conn.request :multipart
      end
    end

    def create(user_id, authorized_subjects, document_resource, file)
    end

    def list(user_id, authorized_subjects)
      assertion = generate_assertion(user_id, authorized_subjects)
      resp = @client.get(LIST_ENDPOINT_PATH) do |req|
        negotiate_json_for(req)
        assertion.encode_and_sign_to_http_request(req, @system_secret)
      end
      data = JSON.parse(resp.body)
      data.map do |data_element|
        CartafactRb::Resources::Document.new(data_element)
      end
    end

    def download(user_id, authorized_subjects, document_id)
      assertion = generate_assertion(user_id, authorized_subjects)
      @client.get(SHOW_ENDPOINT_PATH + document_id.to_s + "/download") do |req|
        assertion.encode_and_sign_to_http_request(req, @system_secret)
      end
    end

    def get(user_id, authorized_subjects, document_id)
      assertion = generate_assertion(user_id, authorized_subjects)
      resp = @client.get(SHOW_ENDPOINT_PATH + document_id.to_s) do |req|
        negotiate_json_for(req)
        assertion.encode_and_sign_to_http_request(req, @system_secret)
      end
      data = JSON.parse(resp.body)
      CartafactRb::Resources::Document.new(data)
    end

    protected

    def generate_assertion(user_id, authorized_subjects)
      CartafactRb::Authorization::Assertion.new(
        @system_name,
        user_id,
        authorized_subjects
      )
    end

    def negotiate_json_for(req)
      req.headers["Content-Type"] = "application/json"
      req.headers["Accept"] = "application/json"
    end
  end
end
