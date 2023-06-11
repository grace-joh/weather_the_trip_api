class HourlyWeather
  attr_reader :time,
              :temperature,
              :condition,
              :icon

  def initialize(data)
    @time = data[:time].to_datetime.strftime('%H:%M')
    @temperature = data[:temp_f]
    @condition = data[:condition][:text]
    @icon = data[:condition][:icon].delete_prefix('//')
  end
end
