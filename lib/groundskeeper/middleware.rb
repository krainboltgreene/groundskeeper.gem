module Groundskeeper
  class Middleware
    NAMESPACE_KEY = "Groundskeeper-Namespace"
    TENANT_KEY = "Groundskeeper-Tenant"
    MODEL_KEY = :model
    QUERY_KEY = :query
    DEFAULT_KEY = :default
    QUERY_DEFAULT = ->(model, slug) do
      model.find_by_slug(slug)
    end

    def initialize(app, options = {})
      raise ArgumentError, "missing model" unless options.key?(model_key)

      @options = options
      @app = app
      @env = {}
    end

    def call(env)
      @env = env
      env[namespace_key] = namespace
      env[tenant_key] = tenant
      @app.call(env)
    end

    private def tenant
      query.call(model, namespace) || default
    end

    private def model
      if @options[model_key].is_a?(String)
        Object.const_get(@options[model_key])
      else
        @options[model_key]
      end
    end

    private def default
      @options[default_key]
    end

    private def query
      @options[query_key] || query_default
    end

    private def namespace_key
      self.class.const_get("NAMESPACE_KEY")
    end

    private def tenant_key
      self.class.const_get("TENANT_KEY")
    end

    private def model_key
      self.class.const_get("MODEL_KEY")
    end

    private def default_key
      self.class.const_get("DEFAULT_KEY")
    end

    private def query_key
      self.class.const_get("QUERY_KEY")
    end

    private def query_default
      self.class.const_get("QUERY_DEFAULT")
    end
  end
end
