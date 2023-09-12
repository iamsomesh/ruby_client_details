require 'json'
require_relative '../client_details'

JSON_DATA = [
  { 'full_name' => 'John Doe', 'email' => 'john.doe@gmail.com' },
  { 'full_name' => 'Alice Smith', 'email' => 'alice@example.com' },
  { 'full_name' => 'Bob Johnson', 'email' => 'bob@example.com' },
  { 'full_name' => 'Jane Doe', 'email' => 'jane@example.com' },
  { 'full_name' => 'Eve Johnson', 'email' => 'eve@example.com' }
].freeze

describe ClientDetails do
  before(:each) do
    File.write('clients.json', JSON.generate(JSON_DATA))
  end

  after(:each) do
    File.delete('clients.json') if File.exist?('clients.json')
  end

  subject(:client_details) { described_class.new('clients.json') }

  context 'when searching' do
    it 'finds clients by full name' do
      expect { client_details.search('full_name', 'John') }.to output(/John Doe/).to_stdout
    end

    it 'finds clients by email' do
      expect { client_details.search('email', 'john.doe@gmail.com') }.to output(/john.doe@gmail.com/).to_stdout
    end

    it 'handles not found' do
      expect { client_details.search('full_name', 'Nonexistent') }.to output(/Full_name not found/).to_stdout
    end
  end

  context 'when finding duplicates' do
    it 'finds clients with duplicate emails' do
      expect { client_details.find_duplicates('jane@example.com') }.to output(/Clients with duplicate emails:/).to_stdout
    end
    

    it 'handles not found' do
      expect { client_details.find_duplicates('nonexistent@email.com') }.to output(/No clients with duplicate emails found/).to_stdout
    end
  end
end
