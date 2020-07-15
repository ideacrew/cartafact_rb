# frozen_string_literal: true

require 'faraday'

module CartafactRb
  module Resources
    class Create
      # Create new instance.
      # @param document_type [String] The type of the document.
      # @param title [String] The title of the document.
      # @param subjects [Array<CartafactRb::Resources::DocumentSubject>] The subjects of this document.
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
        unless @identifier.nil?
          document[:identifier] = @identifier
        end
        unless @description.nil?
          document[:description] = @description
        end
        unless @language.nil?
          document[:language] = @language
        end
        unless @format.nil?
          document[:format] = @format
        end
        unless @date.nil?
          document[:date] = @date
        end
        document
      end
    end
  end
end
