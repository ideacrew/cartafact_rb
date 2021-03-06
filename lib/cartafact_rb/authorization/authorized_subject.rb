# frozen_string_literal: true

module CartafactRb
  module Authorization
    # This class represents entities who are authorized to access a document in the store.
    class AuthorizedSubject
      attr_reader :id
      attr_reader :type

      def initialize(as_type, as_id)
        @id = as_id
        @type = as_type
      end

      def as_json
        {
          id: @id,
          type: @type
        }
      end
    end
  end
end
