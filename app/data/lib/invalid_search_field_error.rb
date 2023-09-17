# frozen_string_literal: true

class InvalidSearchFieldError < StandardError
  def initialize(message = 'Invalid search field. Please specify a valid search field')
    super
  end
end
