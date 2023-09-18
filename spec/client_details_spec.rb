# frozen_string_literal: true

require 'json'
require_relative '../app/client_explorer'

describe ClientDetails do
  subject { described_class.new(options) }

  let(:test_file_path) { File.join('spec', 'support', 'clients.json') }
  let(:search_field) { 'first_name' }
  let(:options) { {} }

  before do
    stub_const('ClientDetails::DEFAULT_DATA_SOURCE', test_file_path)
  end

  describe '.search' do
    let(:query) { 'Alice' }
    let(:result) { subject.search(query) }

    context 'when searching without specifying search_field' do
      let(:valid_output) { [{ 'id' => 2, 'full_name' => 'Alice Smith', 'email' => 'alice@example.com' }] }

      it 'returns valid search results' do
        expect(result).to eq valid_output
        expect(result.count).to be 1
      end
    end

    context 'when searching by specific field' do
      let(:query) { 'duplicate@example.com' }
      let(:options) { { search_field: } }
      let(:valid_output) do
        [{ 'id' => 3, 'full_name' => 'Bob Johnson', 'email' => 'duplicate@example.com' },
         { 'id' => 6, 'full_name' => 'Bob Johnson', 'email' => 'duplicate@example.com' }]
      end

      context 'with valid field' do
        let(:search_field) { 'email' }

        it 'returns valid search results' do
          expect(result).to eq valid_output
          expect(result.count).to be 2
        end
      end

      context 'with invalid field' do
        let(:search_field) { 'invalid_field' }

        it 'raises InvalidSearchFieldError' do
          expect { result }.to raise_error(InvalidSearchFieldError)
        end
      end
    end

    context 'when json is not valid' do
      let(:invalid_file_content) { '' }

      before do
        allow(File).to receive(:read).and_return invalid_file_content
      end

      it 'raises InvalidJsonError' do
        expect { result }.to raise_error(InvalidJsonError)
      end
    end

    context 'when search string is invalid' do
      let(:query) { '' }

      it 'raises InvalidSearchStringError' do
        expect { result }.to raise_error(InvalidSearchStringError)
      end
    end
  end

  describe '.list_duplicates' do
    let(:result) { subject.list_duplicates }

    context 'when duplicates are found' do
      let(:valid_output) do
        { 'duplicate@example.com' => [{ 'id' => 3, 'full_name' => 'Bob Johnson', 'email' => 'duplicate@example.com' },
                                      { 'id' => 6, 'full_name' => 'Bob Johnson', 'email' => 'duplicate@example.com' }] }
      end

      it 'returns duplicate records' do
        expect(result).to eq valid_output
        expect(result.count).to be 1
      end
    end

    context 'with invalid file path' do
      let(:invalid_file_path) { File.join('invalid_file_path') }
      let(:options) { { file_path: invalid_file_path } }

      it 'raises FileNotFoundError' do
        expect { result }.to raise_error(FileNotFoundError)
      end
    end
  end
end
