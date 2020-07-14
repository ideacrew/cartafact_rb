# frozen_string_literal: true

require 'faraday'

module CartafactRb
  module Resources
    class Create
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

      def encode_for_request
        Faraday::ParamPart.new(
          JSON.dump(as_json),
          "application/json"
        )
      end

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
