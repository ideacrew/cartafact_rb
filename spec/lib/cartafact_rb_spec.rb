# frozen_string_literal: true

require "spec_helper"

describe CartafactRb do
  it "defines the client" do
    expect(defined?(::CartafactRb::Client)).to be_truthy
  end

  it "defines the authorization module" do
    expect(defined?(::CartafactRb::Authorization)).to be_truthy
  end

  it "defines the resources module" do
    expect(defined?(::CartafactRb::Resources)).to be_truthy
  end
end
