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

      # @return [String, nil]
      attr_reader :version

      # @api private
      def initialize(json_hash)
        stringed_json = stringify_hash_keys(json_hash)
        extract_required_attributes(stringed_json)
        @description = stringed_json["description"]
        @language = stringed_json["language"]
        @format = stringed_json["format"]
        @date = stringed_json["date"]
        @identifier = stringed_json["identifier"]
        @version = stringed_json["version"]
        @subjects = ::CartafactRb::Resources::DocumentSubject.build_from_hash_array(
          stringed_json["subjects"]
        )
      end

      protected

      def extract_required_attributes(params_hash)
        @id = params_hash["id"]
        @title = params_hash["title"]
        @document_type = params_hash["document_type"]
      end

      def stringify_hash_keys(hash)
        result = {}
        hash.each_key do |key|
          result[key.to_s] = hash[key]
        end
        result
      end
    end
  end
end
