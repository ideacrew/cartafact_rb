require "spec_helper"

describe CartafactRb do
  it "defines the client" do
    expect(defined?(::CartafactRb::Client)).to be_truthy
  end

  it "defines the authorized_identity class" do
    expect(defined?(::CartafactRb::AuthorizedIdentity)).to be_truthy
  end

  it "defines the authorized_subject class" do
    expect(defined?(::CartafactRb::AuthorizedSubject)).to be_truthy
  end
end