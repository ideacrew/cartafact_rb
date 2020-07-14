# frozen_string_literal: true

module CartafactRb
  class Client
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
    end

    def create(user_id, authorized_subjects, document_resource)
    end

    def list(user_id, authorized_subjects)
    end

    def download(user_id, authorized_subjects, document_id)
    end

    def read(user_id, authorized_subjects, document_id)
    end
  end
end
