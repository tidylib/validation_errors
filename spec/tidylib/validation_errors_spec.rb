require 'spec_helper'

RSpec.describe Tidylib::ValidationErrors do
  it 'has a version number' do
    expect(Tidylib::ValidationErrors::VERSION).not_to be nil
  end

  describe "#empty?" do
    it "returns true with no errors" do
      errors = described_class.new
      expect(errors.empty?).to be_truthy
    end

    it "returns false with errors" do
      errors = described_class.new
      errors.add(:name, :present)
      expect(errors.empty?).to be_falsey
    end
  end

  describe "#[]" do
    it "returns errors for a topic" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:baz, :length)

      expect(errors[:foo]).to eq(:presence)
      expect(errors[:baz]).to eq(:length)
    end
  end
end
