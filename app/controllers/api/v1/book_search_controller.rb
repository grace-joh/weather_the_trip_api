class Api::V1::BookSearchController < ApplicationController
  def search
    # params location, quantity
    # facade for booksearch using location, quantity
    # facade for weather using location
    # return json through serializer
    @book_search = BookSearchFacade.new(params[:location], params[:quantity])
    render json: BooksWeatherSerializer.new(@book_search)
  end
end

=begin
  
{
  "data": {
            "id": "null",
            "type": "books",
            "attributes": {
                            "destination": "denver,co",
                            "forecast": {
                                          "summary": "Cloudy with a chance of meatballs",
                                          "temperature": "83 F"
                                        },
                            "total_books_found": 172,
                            "books": [
                                      {
                                        "isbn": [ 
                                                  "0762507845",
                                                  "9780762507849"
                                                ],
                                        "title": "Denver, Co",
                                        "publisher": [
                                                        "Universal Map Enterprises"
                                                      ]
                                      },
                                      {
                                        "isbn": [
                                                  "9780883183663",
                                                  "0883183668"
                                                ],
                                        "title": "Photovoltaic safety, Denver, CO, 1988",
                                        "publisher": [
                                                        "American Institute of Physics"
                                                      ]
                                      },
                                      { ... same format for books 3, 4 and 5 ... }
                                    ]
                          }
          }
}
  
=end
