require 'rails_helper'

RSpec.describe Books do
  it 'exists and has attributes' do
    location = 'denver,co'
    forecast = { "summary": "Cloudy with a chance of meatballs",
                 "temperature": "83 F" }
    total_books_found = 172
    data = {
      "isbn": ['0762507845', '9780762507849'],
      "title": "Denver, Co",
      "publisher": ["Universal Map Enterprises"]
    }
    book = Book.new(data)
    books_list = [book, book, book, book, book]

    books = Books.new(location, forecast, total_books_found, books_list)

    expect(books).to be_a(Books)
    expect(books.destination).to eq(location)
    expect(books.destination).to be_a(String)
    expect(books.forecast).to eq(forecast)
    expect(books.forecast).to be_a(Hash)
    expect(books.total_books_found).to eq(total_books_found)
    expect(books.total_books_found).to be_an(Integer)
    expect(books.books).to eq(books_list)
    expect(books.books).to be_an(Array)
    expect(books.books).to all(be_a(Book))
  end
end
