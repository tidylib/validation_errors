module Tidylib
  class ValidationErrors
    VERSION = "0.1.0"

    def initialize
      @empty = true

    end

    def empty?
      @empty
    end

    def add(topic, message)
      @empty = false
    end
  end
end
