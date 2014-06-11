require "spec_helper"

describe Groundskeeper::VERSION do
  it "should be a string" do
    expect(Groundskeeper::VERSION).to be_kind_of(String)
  end
end
