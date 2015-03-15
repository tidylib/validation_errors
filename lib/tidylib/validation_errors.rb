require 'ostruct'

module Tidylib
  class ValidationErrors
    include Enumerable

    VERSION = "0.1.0"

    def initialize
      @errors = []
    end

    def empty?
      @errors.empty?
    end

    def add(topic, message, context={})
      error = OpenStruct.new(
        topic: topic,
        message: message,
        context: context
      )

      @errors << error
    end

    def [](topic)
      @errors.select do |error|
        error.topic == topic
      end.map do |error|
        [ error.message, error.context ]
      end
    end
    alias :on :[]

    def each(&blk)
      @errors.each do |error|
        yield error.topic, error.message, error.context
      end
    end

    def grouped_by_topic
      @errors.inject({}) do |grouped, error|
        grouped[error.topic] ||= []
        grouped[error.topic] << [error.message, error.context]

        grouped
      end
    end
  end
end
