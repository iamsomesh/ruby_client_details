# frozen_string_literal: true

class InvalidSearchStringError < StandardError
  def initialize(message = 'Invalid search string. Please enter valid search string.')
    super
  end
end
