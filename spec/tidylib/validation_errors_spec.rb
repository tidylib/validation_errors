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

      expect(errors[:foo]).to include(:presence)
      expect(errors[:baz]).to include(:length)
    end

    it "allows multiple errors on a topic" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:foo, :length)

      expect(errors[:foo]).to eq([:presence, :length])
    end
  end

  describe "#on" do
    it "returns errors for a topic" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:baz, :length)

      expect(errors.on(:foo)).to include(:presence)
      expect(errors.on(:baz)).to include(:length)
    end

    it "allows multiple errors on a topic" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:foo, :length)

      expect(errors.on(:foo)).to eq([:presence, :length])
    end
  end

  describe "#each" do
    it "iterates over all the errors" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:bar, :presence)
      errors.add(:foo, :length)

      actual = []
      errors.each do |topic, message|
        actual << [topic, message]
      end

      expect(actual).to eq([
        [ :foo, :presence ],
        [ :bar, :presence],
        [ :foo, :length ]
      ])
    end
  end

  describe "Enumerable integration" do
    it "Enumerable additions #map" do
      errors = described_class.new
      errors.add(:foo, :length)
      errors.add(:bar, :presence)
      errors.add(:foo, :presence)

      actual = errors.select do |topic, message|
        topic == :foo
      end

      expect(actual).to eq( [ [ :foo, :length ] , [ :foo, :presence ] ] )
    end
  end
end
