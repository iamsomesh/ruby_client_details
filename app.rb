require 'thor'
require_relative 'client_details'

class App < Thor
  desc 'search [FIELD] VALUE', 'Search clients by a specific field and value (default: full_name)'
  option :filename, type: :string, default: 'clients.json', desc: 'Specify the JSON file to use'
  def search(field = 'full_name', value)
    client_details = ClientDetails.new(options[:filename])
    client_details.search(field, value)
  end

  desc 'find_duplicates [EMAIL]', 'Find clients with duplicate emails'
  option :filename, type: :string, default: 'clients.json', desc: 'Specify the JSON file to use'
  def find_duplicates(email = nil)
    client_details = ClientDetails.new(options[:filename])
    client_details.find_duplicates(email)
  end
end

App.start
