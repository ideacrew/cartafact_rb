# frozen_string_literal: true

require 'faraday'

module CartafactRb
  module Resources
    # Represents the metadata associated with a request to create a document.
    class Create
      # Create new instance.
      # @param document_type [String] The type of the document.
      # @param title [String] The title of the document.
      # @param subjects [Array<CartafactRb::Resources::DocumentSubject>]
      #   The subjects of this document.
      # @param identifier [String, nil] A special identifier for this document.
      # @param description [String, nil] A description of the document.
      # @param language [String, nil] The language in which the document is written.
      # @param format [String, nil] The MIME-type of the document.
      # @param date [String, nil] The Date/Time on which the document was generated.
      def initialize(
        document_type,
        title,
        subjects: [],
        identifier: nil,
        description: nil,
        language: nil,
        format: nil,
        date: nil
      )
        @document_type = document_type
        @title = title
        @subjects = subjects
        @identifier = identifier
        @description = description
        @language = language
        @format = format
        @date = date
      end

      # @api private
      def encode_for_request
        Faraday::ParamPart.new(
          JSON.dump(as_json),
          "application/json"
        )
      end

      # @api private
      def as_json
        document = {
          title: @title,
          document_type: @doc_type,
          subjects: @subjects.map(&:as_json)
        }
        (document[:identifier] = @identifier) unless @identifier.nil?
        (document[:description] = @description) unless @description.nil?
        (document[:language] = @language) unless @language.nil?
        (document[:format] = @format) unless @format.nil?
        (document[:date] = @date) unless @date.nil?
        document
      end
    end
  end
end
