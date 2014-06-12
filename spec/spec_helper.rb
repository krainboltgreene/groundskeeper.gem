require "pry"
require "rspec"
require "groundskeeper"

shared_context "rack setup" do
  let(:url) { "http://foo.example.com" }
  let(:rack_env) do
    {
      "HTTP_HOST" => URI.parse(url).host,
      "PATH_INFO" => URI.parse(url).path
    }
  end

  let(:namespace) { "foo" }
  let(:model) { double("Model") }
  let(:instance) { instance_double("Model") }

  let(:app) { ->(env) { [200, rack_env, "app"] } }
  let(:options) do { model: model } end
  let(:middleware) { described_class.new(app, options) }
  let(:request) { middleware.call(rack_env) }
  let(:request_code) { request[0] }
  let(:request_env) { request[1] }
  let(:request_namespace) { request_env[Groundskeeper::Middleware::NAMESPACE_KEY] }
  let(:request_tenant) { request_env[Groundskeeper::Middleware::TENANT_KEY] }

  before(:each) do
    allow(model).to receive(:find).and_return(instance)
  end
end
