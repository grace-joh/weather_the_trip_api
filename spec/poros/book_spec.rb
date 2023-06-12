require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes' do
    data = {
      "isbn": ['0762507845', '9780762507849'],
      "title": "Denver, Co",
      "publisher": ["Universal Map Enterprises"]
    }

    book = Book.new(data)

    expect(book).to be_a(Book)
    expect(book.isbn).to eq(data[:isbn])
    expect(book.title).to eq(data[:title])
    expect(book.publisher).to eq(data[:publisher])
  end
end
