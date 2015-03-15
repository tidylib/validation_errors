module Tidylib
  class ValidationErrors
    VERSION = "0.1.0"

    def initialize
      @errors = Hash.new
    end

    def empty?
      @errors.empty?
    end

    def add(topic, message)
      @errors[topic] ||= []
      @errors[topic] << message
    end

    def [](topic)
      @errors[topic]
    end
  end
end
