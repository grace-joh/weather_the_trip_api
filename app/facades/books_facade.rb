class BooksFacade
  def initialize(location, quantity)
    @destination = location
    @quantity_index = quantity - 1
  end

  def get_books
    Books.new(@destination, forecast, total_books_found, list_of_books_by_quantity)
  end

  private

  def total_books_found
    service.search_library(@location)[:numFound]
  end

  def list_of_books_by_quantity
    book_from_library = service.search_library(@destination)[:docs][0..@quantity_index]
    book_from_library.map do |book|
      Book.new(book)
    end
  end

  def forecast
    {
      "summary": current_weather.condition,
      "temperature": "#{current_weather.temperature} F"
    }
  end

  def current_weather
    forecast_data.current_weather
  end

  def forecast_data
    @_forecast ||= ForecastFacade.new(@destination).get_forecast
  end

  def service
    @_service ||= LibraryService.new
  end
end
