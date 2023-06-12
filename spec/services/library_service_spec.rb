require 'rails_helper'

RSpec.describe LibraryService do
  describe 'instance methods' do
    describe '#search_library' do
      before(:each) do
        location = 'denver,co'
        service = LibraryService.new
        @books_data = service.search_library(location)
      end

      it 'returns the books for a location', :vcr do
        expect(@books_data).to be_an(Hash)
        expect(@books_data).to have_key :numFound
        expect(@books_data[:numFound]).to be_an(Integer)
        expect(@books_data).to have_key :docs
        expect(@books_data[:docs]).to be_an(Array)
        expect(@books_data[:docs]).to all(be_a(Hash))
        first_book = @books_data[:docs][0]
        expect(first_book).to have_key :title
        expect(first_book[:title]).to be_a(String)
        expect(first_book).to have_key :isbn
        expect(first_book[:isbn]).to be_an(Array)
        expect(first_book[:isbn]).to all(be_a(String))
        expect(first_book).to have_key :publisher
        expect(first_book[:publisher]).to be_an(Array)
        expect(first_book[:publisher]).to all(be_a(String))
      end
    end
  end
end
