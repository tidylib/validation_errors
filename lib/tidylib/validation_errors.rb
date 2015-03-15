module Tidylib
  class ValidationErrors
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

    def each(&blk)
      @errors.each(&blk)
    end
  end
end
