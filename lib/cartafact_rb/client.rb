# frozen_string_literal: true

require 'faraday'

module CartafactRb
  # The client is the primary interface for interaction with the
  # document store.
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
        conn.adapter :net_http
      end
    end

    # Create a document in the store.
    # @param user_id [String] The ID or Email of the user making the request.
    # @param authorized_subjects [Array<CartafactRb::Authorization::AuthorizedSubject>]
    #   The authorized subjects for the request.
    # @param create_resource [Cartafact::Resources::Document] The document properties.
    # @param file [String, File] The file contents.
    # @return [Cartafact::Resources::Document] The new document.
    def create(user_id, authorized_subjects, create_resource, file)
      assertion = generate_assertion(user_id, authorized_subjects)
      resp = @client.post(CREATE_ENDPOINT_PATH) do |req|
        req.headers["Accept"] = "application/json"
        req.headers["Content-Type"] = "multipart/form-data"
        assertion.encode_and_sign_to_http_request(req, @system_secret)
        body = {}
        body[:document] = create_resource.encode_for_request
        body[:content] = Faraday::UploadIO.new(file, "application/octet-stream")
        req.body = body
      end
      data = JSON.parse(resp.body)
      CartafactRb::Resources::Document.new(data)
    end

    # List matching documents to access is authorized.
    # @param user_id [String] The ID or Email of the user making the request.
    # @param authorized_subjects [Array<CartafactRb::Authorization::AuthorizedSubject>]
    #   The authorized subjects for the request.
    # @return [Array<Cartafact::Resources::Document>] the list of documents
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

    # Download the content of a specific document.
    # @param user_id [String] The ID or Email of the user making the request.
    # @param authorized_subjects [Array<CartafactRb::Authorization::AuthorizedSubject>]
    #   The authorized subjects for the request.
    # @param document_id [String] The ID of the document.
    # @return [Faraday::Response] The service response.
    def download(user_id, authorized_subjects, document_id)
      assertion = generate_assertion(user_id, authorized_subjects)
      @client.get(SHOW_ENDPOINT_PATH + document_id.to_s + "/download") do |req|
        assertion.encode_and_sign_to_http_request(req, @system_secret)
      end
    end

    # Get information about a specific document.
    # @param user_id [String] The ID or Email of the user making the request.
    # @param authorized_subjects [Array<CartafactRb::Authorization::AuthorizedSubject>]
    #   The authorized subjects for the request.
    # @param document_id [String] The ID of the document.
    # @return [Cartafact::Resources::Document] the list of documents
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
