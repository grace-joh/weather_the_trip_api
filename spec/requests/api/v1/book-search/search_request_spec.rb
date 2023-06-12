require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'Get Books (and weather) for a City' do
    describe 'happy path', :vcr do
      before(:each) do
        @location = 'denver,co'
        @quantity = 10
        get "/api/v1/book-search?location=#{@location}&quantity=#{@quantity}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        @denver_book_search = JSON.parse(response.body, symbolize_names: true)
      end

      it 'returns books for a searched location with a specified quanity' do
        expect(@denver_book_search).to be_a(Hash)
        expect(@denver_book_search).to have_key :data
        expect(@denver_book_search[:data]).to be_a(Hash)
        expect(@denver_book_search[:data]).to have_key :id
        expect(@denver_book_search[:data][:id]).to eq(nil)
        expect(@denver_book_search[:data]).to have_key :type
        expect(@denver_book_search[:data][:type]).to eq('books')
        expect(@denver_book_search[:data]).to have_key :attributes
        attributes = @denver_book_search[:data][:attributes]
        expect(attributes).to be_a(Hash)
        expect(attributes).to have_key :destination
        expect(attributes[:destination]).to be_a(String)
        expect(attributes[:destination]).to eq(@location)
        expect(attributes).to have_key :forecast
        expect(attributes[:forecast]).to be_a(Hash)
        expect(attributes[:forecast]).to have_key :summary
        expect(attributes[:forecast][:summary]).to be_a(String)
        expect(attributes[:forecast]).to have_key :temperature
        expect(attributes[:forecast][:temperature]).to be_a(String)
        expect(attributes).to have_key :total_books_found
        expect(attributes[:total_books_found]).to be_an(Integer)
        expect(attributes).to have_key :books
        books = attributes[:books]
        expect(books).to be_an(Array)
        expect(books.count).to eq(@quantity)
        expect(books).to all(be_a(Hash))
        first_book = books[0]
        expect(first_book).to have_key :isbn
        expect(first_book[:isbn]).to be_an(Array)
        expect(first_book[:isbn]).to all(be_a(String))
        expect(first_book).to have_key :title
        expect(first_book[:title]).to be_a(String)
        expect(first_book).to have_key :publisher
        expect(first_book[:publisher]).to be_an(Array)
        expect(first_book[:publisher]).to all(be_a(String))
      end
    end
  end
end
