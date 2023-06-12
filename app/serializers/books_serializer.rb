class BooksSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :destination, :forecast, :total_books_found, :books
end
