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

    def add(topic, message)
      @errors << [ topic, message ]
    end

    def [](topic)
      @errors.select do |error|
        error.first == topic
      end.map(&:last)
    end
    alias :on :[]

    def each(&blk)
      @errors.each(&blk)
    end

    def grouped_by_topic
      @errors.inject({}) do |grouped, error|
        grouped[error.first] ||= []
        grouped[error.first] << error.last

        grouped
      end
    end
  end
end
