module Groundskeeper
  class Middleware
    class Path < Middleware
      PARSE_KEY = :parse
      PARSE_DEFAULT = ->(path) { path.split("/")[1] }
      RACK_PATH_KEY = "PATH_INFO"

      private def namespace
        parse.call(@env[rack_path_key])
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

      private def rack_path_key
        self.class.const_get("RACK_PATH_KEY")
      end
    end
  end
end
