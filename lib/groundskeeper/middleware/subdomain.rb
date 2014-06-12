module Groundskeeper
  class Middleware
    class Subdomain < Middleware
      DEPTH_KEY = :depth
      DEPTH_DEFAULT = -3
      PARSE_KEY = :parse
      PARSE_DEFAULT = ->(fqdn, depth) { fqdn.split(".")[depth] }
      RACK_HOST_KEY = "HTTP_HOST"

      private def namespace
        parse.call(@env[rack_host_key], depth)
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

      private def depth
        @options[depth_key].to_i * -1 || depth_default
      end

      private def depth_key
        self.class.const_get("DEPTH_KEY")
      end

      private def depth_default
        self.class.const_get("DEPTH_DEFAULT")
      end

      private def rack_host_key
        self.class.const_get("RACK_HOST_KEY")
      end
    end
  end
end
