class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :condition,
              :icon

  def initialize(data)
    @last_updated = data[:last_updated]
    @temperature = data[:temp_f]
    @feels_like = data[:feelslike_f]
    @humidity = data[:humidity]
    @uvi = data[:uv]
    @visibility = data[:vis_miles]
    @condition = data[:condition][:text]
    @icon = data[:condition][:icon].delete_prefix("//")
  end
end
