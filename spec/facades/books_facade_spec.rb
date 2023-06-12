require 'rails_helper'

RSpec.describe BooksFacade do
  describe 'instance methods' do
    before(:each) do
      @location = 'denver,co'
      @quantity = 5
      @facade = BooksFacade.new(@location, @quantity)
    end

    describe '#initialize' do
      it 'exists' do
        expect(@facade).to be_a(BooksFacade)
      end
    end

    describe '#get_books' do
      it 'returns a Books object', :vcr do
        expect(@facade.get_books).to be_a(Books)

        # destination
        expect(@facade.get_books.destination).to eq(@location)

        # forecast
        expect(@facade.get_books.forecast).to be_a(Hash)
        expect(@facade.get_books.forecast).to have_key :summary
        expect(@facade.get_books.forecast[:summary]).to be_a(String)
        expect(@facade.get_books.forecast).to have_key :temperature
        expect(@facade.get_books.forecast[:temperature]).to be_a(String)

        # total_books_found
        expect(@facade.get_books.total_books_found).to be_an(Integer)

        # books
        expect(@facade.get_books.books).to be_an(Array)
        expect(@facade.get_books.books.count).to eq(@quantity)
        expect(@facade.get_books.books).to all(be_a(Book))
        first_book = @facade.get_books.books[0]
        expect(first_book).to be_a(Book)
        expect(first_book.isbn).to be_an(Array)
        expect(first_book.isbn).to all(be_a(String))
        expect(first_book.title).to be_a(String)
        expect(first_book.publisher).to be_an(Array)
        expect(first_book.publisher).to all(be_a(String))
      end
    end
  end
end
