require "spec_helper"

describe Groundskeeper::Middleware do
  include_context "rack setup"

  before(:each) do
    allow(middleware).to receive(:namespace).and_return(namespace)
  end

  describe "#call" do
    it "sets the namespace correctly" do
      expect(request_namespace).to eq(namespace)
    end

    it "sets the tenant correctly" do
      expect(request_tenant).to eq(instance)
    end

    context "with a default" do
      let(:default) { double("Default") }
      let(:options) do { model: model, default: default } end

      before(:each) do
        allow(model).to receive(:find).and_return(nil)
      end

      it "sets the default as the tenant" do
        expect(request_tenant).to eq(default)
      end
    end
  end
end
