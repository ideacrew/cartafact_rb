# frozen_string_literal: true

module CartafactRb
  module Resources
    class Document
      attr_reader :id, :title, :document_type
      attr_reader :description, :language, :format
      attr_reader :date, :identifier
      attr_reader :subjects

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
