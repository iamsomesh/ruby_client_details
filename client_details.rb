require 'json'

class ClientDetails
  def initialize(filename = 'clients.json')
    @filename = filename
  end

  def search(field = 'full_name', value)
    clients = load_clients
    matching_clients = clients.select { |client| client[field].to_s.include?(value) }

    if matching_clients.empty?
      puts "#{field.capitalize} not found."
    else
      print_clients(matching_clients, field)
    end
  rescue Errno::ENOENT
    puts "File not found: #{@filename}"
  end

  def find_duplicates(email = nil)
    clients = load_clients
    return if email.nil?
  
    duplicate_clients = find_duplicate_clients(clients, email)
  
    print_duplicate_clients(duplicate_clients)
  rescue Errno::ENOENT
    puts "File not found: #{@filename}"
  end

  private

  def load_clients
    raise Errno::ENOENT unless File.exist?(@filename)

    JSON.parse(File.read(@filename))
  end

  def print_clients(clients, field)
    clients.each do |client|
      if field == 'full_name'
        puts "#{client['full_name']}"
      else
        puts "#{client['email']}"
      end
    end
  end

  def find_duplicate_clients(clients, email)
    clients.select { |client| client['email'] == email }
  end

  def print_duplicate_clients(duplicate_clients)
    if duplicate_clients.nil? || duplicate_clients.empty?
      puts 'No clients with duplicate emails found.'
    else
      puts 'Clients with duplicate emails:'
      duplicate_clients.each do |client|
        puts "#{client['full_name']} (#{client['email']})"
      end
    end
  end
end
