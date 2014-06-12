require "spec_helper"
require "groundskeeper/middleware/path"

describe Groundskeeper::Middleware::Path do
  include_context "rack setup"
  let(:url) { "http://foo.example.com/admin/james/users" }
  let(:namespace) { "admin" }

  describe "#call" do
    it "sets the namespace correctly" do
      expect(request_namespace).to eq(namespace)
    end

    context "looking to namespace on second nested path resource" do
      let(:options) do
        {
          model: model,
          parse: ->(path) { path.split("/").compact[2] }
        }
      end
      let(:namespace) { "james" }

      it "sets the namespace correctly" do
        expect(request_namespace).to eq(namespace)
      end
    end
  end
end
