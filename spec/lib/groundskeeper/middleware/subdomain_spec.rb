require "spec_helper"
require "groundskeeper/middleware/subdomain"

describe Groundskeeper::Middleware::Subdomain do
  include_context "rack setup"

  describe "#call" do
    it "sets the namespace correctly" do
      expect(request_namespace).to eq(namespace)
    end

    context "looking to namespace on domain" do
      let(:options) do { model: model, depth: 2 } end
      let(:namespace) { "example" }

      it "sets the namespace correctly" do
        expect(request_namespace).to eq(namespace)
      end
    end
  end
end
