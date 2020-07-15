# frozen_string_literal: true

module CartafactRb
  module Resources
    # Represents the metadata of a document in the store.
    class Document
      # @return [String]
      attr_reader :id
      # @return [String]
      attr_reader :title
      # @return [String]
      attr_reader :document_type

      # @return [String, nil]
      attr_reader :description

      # @return [String, nil]
      attr_reader :language

      # @return [String, nil]
      attr_reader :format

      # @return [String, nil]
      attr_reader :date

      # @return [String, nil]
      attr_reader :identifier

      # @return [Array<CartafactRb::Resources::DocumentSubject>]
      attr_reader :subjects

      # @api private
      def initialize(json_hash)
        stringed_json = json_hash.stringify_keys
        @id = stringed_json["id"]
        @title = stringed_json["title"]
        @document_type = stringed_json["document_type"]
        @description = stringed_json["description"]
        @language = stringed_json["language"]
        @format = stringed_json["format"]
        @date = stringed_json["date"]
        @identifier = stringed_json["identifier"]
        @subjects = ::CartafactRb::Resources::DocumentSubject.build_from_hash_array(
          stringed_json["subjects"]
        )
      end
    end
  end
end
