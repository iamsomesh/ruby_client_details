# frozen_string_literal: true

class InvalidJsonError < StandardError
  def initialize(message = 'Data in the file in not in valid JSON format')
    super
  end
end
