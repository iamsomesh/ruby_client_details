# frozen_string_literal: true

class FileNotFoundError < StandardError
  def initialize(message = 'File Not Found. Please specify valid file path')
    super
  end
end
