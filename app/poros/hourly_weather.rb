class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = data[:time].to_datetime.strftime('%H:%M')
    @temperature = data[:temp_f]
    @conditions = data[:condition][:text]
    @icon = data[:condition][:icon].delete_prefix('//')
  end
end
