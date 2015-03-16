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

      expect(errors[:foo]).to eq([
        [:presence, {}]
      ])
      expect(errors[:baz]).to eq([
        [:length, {}]
      ])
    end

    it "allows multiple errors on a topic" do
      errors = described_class.new
      errors.add(:foo, :presence)
      errors.add(:foo, :length)

      expect(errors[:foo]).to eq([
        [ :presence, {} ],
        [ :length, {} ]
      ])
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

      expect(actual).to eq( [ [ :foo, :length, {} ] , [ :foo, :presence, {} ] ] )
    end
  end

  describe "#grouped_by_topic" do
    it "returns the errors grouped by topic" do
      errors = described_class.new
      errors.add(:foo, :length)
      errors.add(:bar, :presence)
      errors.add(:foo, :presence)

      grouped_errors = errors.grouped_by_topic

      expect(grouped_errors.keys).to eq([:foo, :bar])
      expect(grouped_errors[:foo]).to eq([
        [:length, {}],
        [:presence, {}]
      ])
      expect(grouped_errors[:bar]).to eq([
        [:presence, {}]
      ])
    end
  end

  describe "context" do
    it "allows errors to be set with context" do
      errors = described_class.new
      errors.add(:foo, :age_limit, { required_age: 21 })

      expect(errors.on(:foo)).to eq([
        [:age_limit, { required_age: 21 }]
      ])
    end
  end

  describe "#clear" do
    it "clears all the errors" do
      errors = described_class.new
      errors.add(:foo, :age_limit)
      expect(errors.empty?).to be_falsey
      errors.clear
      expect(errors.empty?).to be_truthy
    end
  end

  describe "#count" do
    it "returns the total number of errors added" do
      errors = described_class.new
      expect(errors.count).to eq 0

      errors.add(:foo, :present)
      expect(errors.count).to eq 1

      errors.add(:bar, :present)
      expect(errors.count).to eq 2

      errors.add(:bar, :length)
      expect(errors.count).to eq 3
    end
  end
end
