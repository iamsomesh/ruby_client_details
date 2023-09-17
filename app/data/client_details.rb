# frozen_string_literal: true

require 'json'
require_relative 'lib/errors/main'

class ClientDetails
  attr_reader :file_path, :search_field

  DEFAULT_DATA_SOURCE = File.join('app', 'data', 'clients.json')
  VALID_SEARCH_FIELDS = %w[id full_name email].freeze
  DEFAULT_SEARCH_FIELD = :full_name

  def initialize(options = {})
    @file_path = options[:file_path].to_s
    @search_field = (options[:search_field] || DEFAULT_SEARCH_FIELD).to_s
  end

  def list
    clients
  end

  # Find clients by full name or valid search field if given
  def search(value)
    raise InvalidSearchStringError if value.empty?

    # Using downcase for case insensitive search
    clients.select { |client| client[valid_search_field]&.downcase&.include?(value.downcase) }
  end

  # Find clients with duplicate emails
  def list_duplicates
    clients.group_by { |h| h['email'] }.select { |_k, v| v.count > 1 }
  end

  private

  def clients
    @clients ||= JSON.parse(File.read(data_source_path))
  rescue JSON::ParserError, TypeError
    raise InvalidJsonError
  end

  def data_source_path
    return DEFAULT_DATA_SOURCE if file_path.empty?
    raise FileNotFoundError unless File.exist?(file_path)

    file_path
  end

  def valid_search_field
    return search_field if VALID_SEARCH_FIELDS.include? search_field

    raise InvalidSearchFieldError
  end
end
