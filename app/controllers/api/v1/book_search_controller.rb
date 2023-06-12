class Api::V1::BookSearchController < ApplicationController
  def search
    book_search = BooksFacade.new(params[:location], params[:quantity].to_i).get_books
    render json: BooksSerializer.new(book_search)
  end
end