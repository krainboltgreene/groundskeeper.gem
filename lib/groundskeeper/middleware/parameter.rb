module Groundskeeper
  class Middleware
    class Parameter < Middleware
      PARSE_KEY = :parse
      PARSE_DEFAULT = ->(params) { params[PARAM_DEFAULT_KEY] }
      PARAM_DEFAULT_KEY = "tenant"

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
