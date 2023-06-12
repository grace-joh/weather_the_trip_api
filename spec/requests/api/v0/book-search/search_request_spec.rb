require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'Get Books (and weather) for a City' do
    describe 'happy path', :vcr do
      before(:each) do
        get '/api/v1/book-search?location=denver,co&quanitity=5'

        expect(response).to be_successful
        expect(response.status).to eq(200)

        @denver_book_search = JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
