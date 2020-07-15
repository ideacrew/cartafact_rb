# frozen_string_literal: true

module CartafactRb
  module Resources
    # This class represents the subjects of a document.
    class DocumentSubject
      attr_reader :id, :type

      def initialize(id, type)
        @id = id
        @type = type
      end

      # @api private
      def self.build_from_hash_array(h_array)
        return [] if h_array.nil?

        h_array.map do |h|
          h_stringed = stringify_hash_keys(h)
          new(h_stringed["id"], h_stringed["type"])
        end
      end

      # @api private
      def as_json
        {
          id: @id,
          type: @type
        }
      end

      protected

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
