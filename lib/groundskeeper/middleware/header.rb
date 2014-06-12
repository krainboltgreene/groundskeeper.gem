module Groundskeeper
  class Middleware
    class Header < Middleware
      PARSE_KEY = :parse
      PARSE_DEFAULT = ->(headers) { headers[HEADER_DEFAULT_KEY] }
      HEADER_DEFAULT_KEY = "Groundskeeper-Namespace"

      private def namespace
        # parse.call()
      end

      private def parse
        @options[parse_key] || parse_default
      end

      private def parse_key
        self.class.const_get("PARSE_KEY")
      end

      private def parse_default
        self.class.const_get("PARSE_DEFAULT")
      end
    end
  end
end
